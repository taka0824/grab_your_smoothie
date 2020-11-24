class EndUsers::EndUsersController < ApplicationController
  before_action :authenticate_end_user!
  def index
    @end_users = EndUser.all.where(is_deleted: false)
  end

  def show
    @end_user = EndUser.find(params[:id])
    @smoothie = @end_user.smoothies.find_by(is_recommended: true)
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
    end_user = EndUser.find(params[:id])
    end_user.update(end_user_params)
    redirect_to request.referer
  end

  def recipe_list
    @smoothies = Smoothie.where(end_user_id: params[:id])
    @end_user = EndUser.find(params[:id])
  end

  def favorite_list
    @end_user = EndUser.find(params[:id])
    @favorited_smoothies = @end_user.favorited_smoothies
  end

  def destroy_confirm
  end

  def is_deleted_update
    EndUser.find(params[:id]).update(is_deleted: true)
    redirect_to root_path
  end

  private
  def end_user_params
    params.require(:end_user).permit(:name, :email)
  end

end
