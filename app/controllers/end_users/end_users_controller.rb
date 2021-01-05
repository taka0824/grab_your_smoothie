class EndUsers::EndUsersController < ApplicationController
  before_action :authenticate_end_user!
  def index
    end_users_with_post = EndUser.active.joins(:smoothies).group(:id).order('count(end_users.id) desc')
    end_users_without_post = EndUser.active
    @end_users = []
    end_users_with_post.each do |w|
      @end_users <<  w
    end
    end_users_without_post.each do |wo|
      @end_users << wo
    end
    @end_users = @end_users.uniq
    @end_users = Kaminari.paginate_array(@end_users).page(params[:page]).per(10)
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
    @smoothies = Smoothie.where(end_user_id: params[:id]).order(created_at: "DESC").page(params[:page]).per(9)
    @end_user = EndUser.find(params[:id])
  end

  def favorite_list
    @end_user = EndUser.find(params[:id])
    @favorited_smoothies = @end_user.favorited_smoothies.joins(:favorites).distinct.order("favorites.created_at desc").page(params[:page]).per(9)
    # joinsを使用する場合はdistinctの記述が必要
    # @favorited_smoothies = @end_user.favorited_smoothies.includes(:favorites).order("favorites.created_at desc").page(params[:page]).per(9)
    # includesの場合はdistinctが不要
    # @favorited_smoothies = @end_user.favorited_smoothies.page(params[:page]).per(9)
    # モデルにorderを指定する場合はコントローラでの記述は不要
  end

  def ingredient_list
    @ingredients = current_end_user.ingredients.page(params[:page]).per(9)
  end

  def destroy_confirm
  end

  def is_deleted_update
    end_user = EndUser.find(params[:id])
    end_user.update(is_deleted: true)
    end_user.smoothies.destroy_all
    end_user.comments.destroy_all
    end_user.favorites.destroy_all
    end_user.juicer_ingredients.destroy_all
    end_user.active_notifications.destroy_all
    end_user.passive_notifications.destroy_all
    flash[:success] = "退会しました"
    redirect_to root_path
  end

  private
  def end_user_params
    params.require(:end_user).permit(:name, :email)
  end

end
