class EndUsers::JuicerIngredientsController < ApplicationController
  before_action :authenticate_end_user!
  def create
    @juicer_ingredient = current_end_user.juicer_ingredients.new(juicer_ingredient_params)
    if current_end_user.juicer_ingredients.find_by(ingredient_id: params[:juicer_ingredient][:ingredient_id]).present?
      juicer_ingredient = current_end_user.juicer_ingredients.find_by(ingredient_id: params[:juicer_ingredient][:ingredient_id])
      juicer_ingredient.amount += params[:juicer_ingredient][:amount].to_i
      juicer_ingredient.save
      redirect_to end_users_juicer_ingredients_path
    else
      @juicer_ingredient.save
      redirect_to end_users_juicer_ingredients_path
    end
  end

  def index
    @juicer_ingredients = current_end_user.juicer_ingredients
  end

  def destroy
    JuicerIngredient.find(params[:id]).destroy
    redirect_to request.referer
  end

  def destroy_all
    JuicerIngredient.where(end_user_id: current_end_user.id).destroy_all
    redirect_to request.referer
  end

  private
  def juicer_ingredient_params
    params.require(:juicer_ingredient).permit(:ingredient_id, :amount)
  end
end
