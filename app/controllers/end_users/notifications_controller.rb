class EndUsers::NotificationsController < ApplicationController
  before_action :authenticate_end_user!

  def index
    @notifications = current_end_user.passive_notifications.page(params[:page]).per(15)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

end