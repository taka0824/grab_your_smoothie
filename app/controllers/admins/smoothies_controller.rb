class Admins::SmoothiesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @smoothies = Smoothie.all.order(created_at: "DESC").page(params[:page]).per(9)
  end

  def todays_smoothies
    range = Date.today.beginning_of_day..Date.today.end_of_day
    @smoothies = Smoothie.where(created_at: range).page(params[:page]).per(9)
  end

  def show
    @smoothie = Smoothie.find(params[:id])
  end

  def destroy
    smoothie = Smoothie.find(params[:id])
    @end_user = smoothie.end_user
    smoothie.destroy
    NotificationMailer.send_when_rule_violation(@end_user).deliver
    @end_user.rule_violation_number += 1
    @end_user.save
    if @end_user.rule_violation_number == 5
      NotificationMailer.send_when_rule_violation_resign(@end_user).deliver
      @end_user.discard
    end
    flash[:success] = "スムージー投稿を削除しました"
    redirect_to admins_smoothies_path
  end

end
