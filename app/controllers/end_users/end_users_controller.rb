class EndUsers::EndUsersController < ApplicationController
  before_action :authenticate_end_user!
  def index
    @end_users = EndUser.all.active.page(params[:page]).per(10)
  end

  def show
    @end_user = EndUser.find(params[:id])
    @smoothie = @end_user.smoothies.find_by(is_recommended: true)
  end

  def edit
    @end_user = EndUser.find(params[:id])
    if @end_user.id != current_end_user.id
      redirect_to edit_end_users_end_user_path(current_end_user.id)
    end
  end

  def update
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      flash[:notice] = "アカウント情報を更新しました"
      redirect_to request.referer
    else
      render "end_users/end_users/edit"
    end
  end

  def recipe_list
    @smoothies = Smoothie.where(end_user_id: params[:id]).page(params[:page]).per(9)
    @end_user = EndUser.find(params[:id])
  end

  def favorite_list
    @end_user = EndUser.find(params[:id])
    @favorited_smoothies = @end_user.favorited_smoothies.page(params[:page]).per(9)
  end
  
  def ingredient_list
    @ingredients = current_end_user.ingredients.page(params[:page]).per(9)
  end

  def destroy_confirm
  end

  def is_deleted_update
    EndUser.find(params[:id]).update(is_deleted: true)
    flash[:notice] = "退会しました"
    redirect_to root_path
  end

  private
  def end_user_params
    params.require(:end_user).permit(:name, :email)
  end

end
