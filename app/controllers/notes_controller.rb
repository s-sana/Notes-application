# frozen_string_literal: true

# Managing the notes
class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_note, only: %i[
    show
    edit
    update
    destroy
    shownote
    sharednote
    important
    unimportant
  ]

  # GET /notes/1/important
  def important
    if @note.important == true
      # render plain:[@note].inspect
      @note.update(important: false)
      redirect_to notes_path
    elsif @note.important == false
      @note.update(important: true)
      redirect_to notes_path
    end
  end

  # PATCH /notes/auto_save
  def auto_save
    if current_user.autosave == true
      current_user.update(autosave: false)
      respond_to do  |format|
        format.js { render js: 'window.location.href = "notes";' }

      end
    else
      current_user.update(autosave: true)
      respond_to do  |format|
        format.js {render js: 'window.location.href = "notes";' }
      end
    end
  end

  # GET /notes/tags/:tag
  def tagged_notes
    if params[:tag]
      @notes = Note.tagged_with(params[:tag]).where(
        user_id: current_user.id,
        status: true
      )
    end
  end

  # GET /notes
  # GET /notes.json
  def index
    @note = Note.where(user_id: current_user.id, status: true)
    @notes =
      if params[:search]
        @notes = Note.includes(:tags,:taggings).references(:tags).where(
          'notes.title LIKE :search OR notes.description LIKE :search OR tags.name LIKE :search',
          search: "%#{params[:search]}%"
        ).paginate(
          page: params[:page],
          per_page: 4
        ).where(
          status: true,
          user_id: current_user.id
        ).distinct
      else
        @notes = Note.includes(:tags,:taggings).references(:tags).where(
          status: true,
          user_id: current_user.id
        ).order(
          created_at: :desc
        ).paginate(
          page: params[:page],
          per_page: 4
        )
      end
  end

  # GET /notes/1
  # GET /notes/1.json
  def show; end

  # GET /notes/1/shownote
  def shownote
    @comments = Note.paginate(page: params[:page], per_page: 2)
    @edit = @note.note_shares.find_by(edit: true)
    @user = @note.user.id
    # render plain:[@edit,@user].inspect
  end

  # GET /notes/1/sharednote
  def sharednote
    @comments = Note.paginate(page: params[:page], per_page: 2)
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
    respond_to do |format|
      format.html # edit.html.erb
      format.js # edit.js.erb
      format.json { render json: @note }
    end
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)
    @note.save
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    @note.update(note_params)

    respond_to do |format|
      format.json { render json: flash.to_hash }
    end

  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.update(status: false)
    respond_to do |format|
      format.html do
        redirect_to notes_url,
        notice: 'Note was successfully destroyed.'
      end
      format.json do
        head :no_content
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_note
    @note = Note.find(params[:id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def note_params
    params.require(:note).permit(
      :title,
      :description,
      :user_id,
      :tag_list,
      :important
    )
  end
end
