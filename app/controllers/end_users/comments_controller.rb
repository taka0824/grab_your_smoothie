class EndUsers::CommentsController < ApplicationController
  before_action :authenticate_end_user!

  def new
    @smoothie = Smoothie.find(params[:smoothy_id])
    @comment = Comment.new
    @comments = @smoothie.comments
  end

  def create
    comment = current_end_user.comments.new(comment_params)
    comment.smoothie_id = params[:smoothy_id]
    comment.save
    redirect_to request.referer
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to request.referer
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

end
