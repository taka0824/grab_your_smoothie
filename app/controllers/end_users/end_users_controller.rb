class EndUsers::EndUsersController < ApplicationController
  before_action :authenticate_end_user!
  def index
    @end_users = EndUser.active.order_by_smoothie_number.page(params[:page]).per(10)
  end

  def show
    @end_user = EndUser.find(params[:id])
    @smoothie = @end_user.smoothies.find_by(is_recommended: true)
  end

  def edit
    @end_user = EndUser.find(params[:id])
    if @end_user.id != current_end_user.id
      redirect_to edit_end_user_path(current_end_user.id)
    end
  end

  def update
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      flash.now[:success] = "アカウント情報を更新しました"
    end
  end

  def recipe_list
    @smoothies = Smoothie.created_at_desc(params[:id]).page(params[:page]).per(9)
    @end_user = EndUser.find(params[:id])
  end

  def favorite_list
    @end_user = EndUser.find(params[:id])
    @favorited_smoothies = @end_user.favorited_smoothies.favorite_created_at_desc.page(params[:page]).per(9)
  end

  def ingredient_list
    @ingredients = current_end_user.ingredients.page(params[:page]).per(9)
  end

  def destroy_confirm
  end

  def is_deleted_update
    end_user = EndUser.find(params[:id])
    end_user.resign_process
    flash[:success] = "退会しました"
    redirect_to root_path
  end

  private
  def end_user_params
    params.require(:end_user).permit(:name, :email)
  end

end
