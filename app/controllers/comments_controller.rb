class CommentsController < ApplicationController

  def index
  end
  
  def show
  end

  def new
    @comment = Comment.new
    @note = Note.find(params[:note_id])
  end

  def create
    @note = Note.find(params[:note_id])
    @comment = @note.comments.create(comment_params)
    redirect_to notes_path
    #@cm = @note.comments.paginate(:page => params[:page], :per_page => 2 )
  end

  def edit
    @note = Note.find(params[:note_id])
    @comment = @note.comments.find(params[:id])
    #redirect_to notes_path(@note)
  end

  def update
    #@comments = Comment.all
    @note = Note.find(params[:note_id])
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    redirect_to notes_path(@note)
  end


  def destroy
    @note = Note.find(params[:note_id])
    @comment = @note.comments.find(params[:id])
    @comment.destroy
    redirect_to notes_path
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end

end
