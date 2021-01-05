class Admins::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @comments = Comment.all.order(created_at: "DESC").page(params[:page]).per(10)
  end

  def todays_comments
    range = Date.today.beginning_of_day..Date.today.end_of_day
    @comments = Comment.where(created_at: range).order(created_at: "DESC").page(params[:page]).per(10)
  end

  def destroy
    comment = Comment.find(params[:id])
    @end_user = comment.end_user
    comment.destroy
    @end_user.rule_violation_number += 1
    @end_user.save
    NotificationMailer.send_when_rule_violation(@end_user).deliver if @end_user.rule_violation_number < 5
    @end_user.rule_violation_delete_process if @end_user.rule_violation_number == 5
    flash[:success] = "コメントを削除しました"
    redirect_to request.referer
  end

end