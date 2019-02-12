class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  require 'will_paginate/collection'
  require 'will_paginate/array'
  # GET /notes
  # GET /notes.json
  def index
    @note = Note.where(user_id: current_user.id , status: true)
  #  @notes = Note.where(status: true).order(created_at: :desc)
    @notes = if params[:search]
      Note.where('title LIKE ?', "%#{params[:search]}%" )
    #  Note.where('"title LIKE ?", ''%#{params[:search]}%',status: true, user_id: current_user.id)
    #  Note.where(status: true ,user_id: current_user.id , 'title LIKE :query', query: "%#{params[:search]}%" )
    else
      @nm = Note.where(status: true, user_id: current_user.id).order(created_at: :desc).paginate(:page => params[:page], :per_page => 2)
    end

  #  @nm = Note.paginate(:page => params[:page], :per_page => 2)
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
  end

  def shownote
    @note = Note.find(params[:note_id])

  end
  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create

    @note = Note.new(note_params)

    respond_to do |format|
      if @note.save
          format.html { redirect_to notes_path,notice:' Note was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to notes_path , notice: 'Note was successfully updated.' }

      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.update(status: false)
    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:title, :description, :user_id )
    end



end
