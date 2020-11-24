class EndUsers::SmoothiesController < ApplicationController
  before_action :authenticate_end_user!

  def new
    @smoothie = Smoothie.new
    @juicer_ingredients = JuicerIngredient.where(end_user_id: current_end_user)
  end

  def new_smoothies
    @smoothies = Smoothie.all.order(created_at: "DESC").limit(9)
  end

  def smoothie_ranking
    @all_ranks = Smoothie.joins(:favorites).where(favorites: {created_at: Time.now.all_month}).group(:id).order('count(favorites.smoothie_id) desc').limit(9)
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
    @smoothie.save

    current_end_user.juicer_ingredients.each do |smoothie_ingredient|
      ingredient_id = smoothie_ingredient.ingredient.id
      amount = smoothie_ingredient.amount
      SmoothieIngredient.new(smoothie_id: @smoothie.id, ingredient_id: ingredient_id, amount: amount).save
    end

    current_end_user.juicer_ingredients.destroy_all
    redirect_to root_path
  end

  def destroy
    smoothie = Smoothie.find(params[:id])
    id = smoothie.end_user_id
    smoothie.destroy
    redirect_to recipe_list_end_users_end_user_path(id)
  end

  def is_recommended_update
    end_user = Smoothie.find(params[:id]).end_user
    if end_user.smoothies.where(is_recommended: true)
      end_user.smoothies.where(is_recommended: true).update(is_recommended: false)
    end
    smoothie = Smoothie.find(params[:id])
    smoothie.update(is_recommended: true)
    redirect_to request.referer
  end

  private
  def smoothie_params
    params.require(:smoothie).permit(:image, :introduction, :is_recommended)
  end
end
