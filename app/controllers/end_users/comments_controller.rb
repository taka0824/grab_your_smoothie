class EndUsers::CommentsController < ApplicationController
  before_action :authenticate_end_user!

  def new
    @smoothie = Smoothie.find(params[:smoothy_id])
    @comment = Comment.new
    @comments = @smoothie.comments
  end

  def create
    @comment = current_end_user.comments.new(comment_params)
    @smoothie = Smoothie.find(params[:smoothy_id])
    @comment.smoothie_id = @smoothie.id
    if @comment.save
      flash[:notice] = "コメントを投稿しました"
      redirect_to new_end_users_smoothy_comment_path(@smoothie)
    else
      @comments = @smoothie.comments
      render "end_users/comments/new"
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    smoothie = comment.smoothie
    comment.destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to new_end_users_smoothy_comment_path(smoothie)
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

end
