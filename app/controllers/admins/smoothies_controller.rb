class Admins::SmoothiesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @smoothies = Smoothie.all.order(created_at: "DESC").page(params[:page]).per(9)
  end

  def todays_smoothies
    @smoothies = Smoothie.today.page(params[:page]).per(9)
  end

  def show
    @smoothie = Smoothie.find(params[:id])
  end

  def destroy
    smoothie = Smoothie.find(params[:id])
    @end_user = smoothie.end_user
    smoothie.destroy
    @end_user.rule_violation_number += 1
    @end_user.save
    NotificationMailer.send_when_rule_violation(@end_user).deliver if @end_user.rule_violation_number < 5
    @end_user.rule_violation_delete_process if @end_user.rule_violation_number == 5
    flash[:success] = "スムージー投稿を削除しました"
    redirect_to admins_smoothies_path
  end

end
