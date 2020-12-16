class EndUsers::CommentsController < ApplicationController
  before_action :authenticate_end_user!

  def index
    @smoothie = Smoothie.find(params[:smoothy_id])
    @comment = Comment.new
    @comments = @smoothie.comments.order(created_at: "DESC").page(params[:page]).per(10)
  end

  def create
    @comment = current_end_user.comments.new(comment_params)
    @smoothie = Smoothie.find(params[:smoothy_id])
    # 非同期通信のrender先で必要な変数
    @comment.smoothie_id = @smoothie.id
    @comments = @smoothie.comments.order(created_at: "DESC").page(params[:page]).per(10)
    # 非同期通信のrender先で必要な変数
    @comment.score = Language.get_data(comment_params[:content])
    if @comment.save
      @smoothie.create_notification_comment(current_end_user, @comment.id)
      flash.now[:success] = "コメントを投稿しました"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @smoothie = @comment.smoothie
    # 非同期通信のrender先で必要な変数
    @comments = @smoothie.comments.order(created_at: "DESC").page(params[:page]).per(10)
    # 非同期通信のrender先で必要な変数
    @comment.destroy
    flash.now[:success] = "コメントを削除しました"
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

end
