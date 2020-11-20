class EndUsers::EndUsersController < ApplicationController

  def index
    @end_users = EndUser.all.where(is_deleted: false)
  end

  def show
    @end_user = EndUser.find(params[:id])
    @smoothie = @end_user.smoothies.find_by(is_recommended: true)
    if @smoothie != nil
      @smoothie_ingredients = @smoothie.smoothie_ingredients
    end
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

  def destroy
    EndUser.find(params[:id]).destroy
    redirect_to root_path
  end

end
