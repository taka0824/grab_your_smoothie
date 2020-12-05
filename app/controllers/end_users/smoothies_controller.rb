class EndUsers::SmoothiesController < ApplicationController
  before_action :authenticate_end_user!

  def new
    if JuicerIngredient.where(end_user_id: current_end_user.id).empty?
      redirect_to end_users_juicer_ingredients_path
    end
    @smoothie = Smoothie.new
    @juicer_ingredients = JuicerIngredient.where(end_user_id: current_end_user)
  end

  def new_smoothies
    @smoothies = Smoothie.all.order(created_at: "DESC").page(params[:page]).per(9)
  end

  def smoothie_ranking
    # @all_ranks = Smoothie.joins(:favorites).where("created_at between '30.days.ago.beginning_of_day' and 'Date.yesterday.end_of_day'").group(:id).order('count(favorites.smoothie_id) desc').limit(9)
    # 上の記述は今月分のいいねだけを対象
    @all_ranks = Smoothie.joins(:favorites).group(:id).order('count(favorites.smoothie_id) desc').limit(9)
  end

  def show
    @smoothie = Smoothie.find(params[:id])
  end

  def create
    @smoothie = Smoothie.new(smoothie_params)
    @smoothie.end_user_id = current_end_user.id
    if params[:smoothie][:is_recommended] == "true"
      if current_end_user.smoothies.where(is_recommended: true)
        smoothie = current_end_user.smoothies.where(is_recommended: true)
        smoothie.update(is_recommended: false)
      end
    end
    if @smoothie.save
      current_end_user.juicer_ingredients.each do |smoothie_ingredient|
        ingredient_id = smoothie_ingredient.ingredient.id
        amount = smoothie_ingredient.amount
        SmoothieIngredient.new(smoothie_id: @smoothie.id, ingredient_id: ingredient_id, amount: amount).save
      end
      current_end_user.juicer_ingredients.destroy_all
      flash[:success] = "スムージーレシピを投稿しました"
      redirect_to root_path
    else
      @juicer_ingredients = JuicerIngredient.where(end_user_id: current_end_user)
      render "end_users/smoothies/new"
    end
  end

  def destroy
    smoothie = Smoothie.find(params[:id])
    id = smoothie.end_user_id
    smoothie.destroy
    flash[:success] = "スムージー投稿を削除しました"
    redirect_to recipe_list_end_users_end_user_path(id)
  end

  def is_recommended_update
    end_user = Smoothie.find(params[:id]).end_user
    if end_user.smoothies.where(is_recommended: true)
      end_user.smoothies.where(is_recommended: true).update(is_recommended: false)
    end
    smoothie = Smoothie.find(params[:id])
    smoothie.update(is_recommended: true)
    flash[:success] = "おすすめレシピを変更しました"
    redirect_to request.referer
  end

  private
  def smoothie_params
    params.require(:smoothie).permit(:image, :introduction, :is_recommended)
  end
end
