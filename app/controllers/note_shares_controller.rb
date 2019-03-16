# frozen_string_literal: true

# Managing the notes sharing
class NoteSharesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_note, only: %i[
    show
    edit
    update
    destroy
    request_edit
    update_edit_request
  ]

  # GET /notes/note_shares/shared_by_me
  def shared_by_me
    @noteshares = NoteShare.includes(
      :note
    ).all.where(
      notes: { status: true },
      user_id: current_user.id
    ).distinct
  end

  # PATCH /notes/notes_shares/edit_permission
  def edit_permission
    if NoteShare.edit == true
      NoteShare.update(edit: false)
      respond_to do |format|
        format.js { render js: 'window.location.href = "notes";' }
      end
    else
      NoteShare.update(edit: true)
      respond_to do |format|
        format.js { render js: 'window.location.href = "notes";' }
      end
    end
  end

  # GET /notes/note_shares/request_edit
  def request_edit
    @sender_email = current_user.email
    @receiver_email = User.find(@note.user_id).email

    SendMailMailer.with(
      note: @note,
      sender_email: @sender_email,
      receiver_email: @receiver_email,
      noteurl: @note.id
    ).request_edit_email.deliver!
    redirect_to notes_path, notice: 'Edit Request Sent'
  end

  def update_edit_request
    if @noteshare.edit == true
      @noteshare.update(edit: false)
      redirect_to notes_path, notice: 'EDIT Access updated to false'
    elsif @noteshare.edit == false
      @noteshare.update(edit: true)
      redirect_to notes_path, notice: 'EDIT Access updated to true'
      @receiver_email = @noteshare.email
      @sender_email = current_user.email

      SendMailMailer.with(
        note: @note,
        sender_email: @sender_email,
        receiver_email: @receiver_email,
        noteurl: @note.id
      ).update_edit_request.deliver!
    end
  end

  def index
    @noteshares = NoteShare.includes(:note, :user).all.where(
      email: current_user.email
    ).where(
      notes: { status: true }
    ).distinct
  end

  def new
    @noteshare = NoteShare.new
    @notes = Note.all
    @note = @notes.find(params[:note_id])
  end

  def create
    email = User.where(
      email: params[:note_share][:email]
    ).exists?
    @name = current_user.username
    @note = Note.find(params[:note_id])
    @noteshare = @note.note_shares.create!(note_share_params)
    if @noteshare
      if email
        SendMailMailer.with(
          user: @noteshare,
          username: @name,
          noteurl: @noteshare.note_id
        ).note_email.deliver!
      else
        SendMailMailer.with(
          user: @noteshare,
          username: @name
        ).signup_email.deliver!
      end
    end
    respond_to do |format|
      format.js { render js: 'window.location.href = "notes";' }
    end
  end

  private

  def note_share_params
    params.require(:note_share).permit(
      :email,
      :user_id,
      :note_id,
      :edit,
      :view
    )
  end

  def set_note
    @noteshare = NoteShare.find(params[:id])
    @note = Note.find(params[:id])
  end
end
