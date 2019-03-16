# frozen_string_literal: true

# Managing the notes comments
class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_note, only: %i[
    show
    new
    create
    edit
    update
    destroy
  ]

  # GET /notes/1/comments
  def index; end

  # GET /notes/1/comments/1
  # GET /notes/1/comments/2
  def show; end

  # GET /notes/1/comments/new
  def new
    @comment = Comment.new
  end

  # POST /notes/1/comments
  def create
    @comment = @note.comments.create(comment_params)
    redirect_to notes_path
  end

  # GET /notes/1/comments/1
  # GET /notes/1/comments/2
  def edit
    @comment = @note.comments.find(params[:id])
  end

  # PATCH /notes/1/comments/1
  def update
    @comment = Comment.find(params[:id])
    redirect_to notes_path(@note) if @comment.update(comment_params)
    # end
  end

  # DELETE /notes/1/comments/1
  def destroy
    @comment = @note.comments.find(params[:id])
    @comment.destroy
    redirect_to notes_path
  end

  private

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_note
    @note = Note.find(params[:note_id])
  end
end
