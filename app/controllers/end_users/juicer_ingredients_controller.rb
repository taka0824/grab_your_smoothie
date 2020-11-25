class EndUsers::JuicerIngredientsController < ApplicationController
  before_action :authenticate_end_user!

  def create
    @juicer_ingredient = current_end_user.juicer_ingredients.new(juicer_ingredient_params)
    @ingredient = Ingredient.find(params[:juicer_ingredient][:ingredient_id])
    if current_end_user.juicer_ingredients.find_by(ingredient_id: params[:juicer_ingredient][:ingredient_id]).present?
      juicer_ingredient = current_end_user.juicer_ingredients.find_by(ingredient_id: params[:juicer_ingredient][:ingredient_id])
      juicer_ingredient.amount += params[:juicer_ingredient][:amount].to_i
      juicer_ingredient.save
      flash[:notice] = "材料を追加しました"
      redirect_to end_users_juicer_ingredients_path
    else
      if @juicer_ingredient.save
        flash[:notice] = "材料を追加しました"
        redirect_to end_users_juicer_ingredients_path
      else
        render "end_users/ingredients/show"
      end
    end
  end

  def index
    @juicer_ingredients = current_end_user.juicer_ingredients
    @juicer_ingredient = JuicerIngredient.new
  end

  def update
    @juicer_ingredient = JuicerIngredient.find(params[:id])
    if params[:juicer_ingredient][:amount] == "0"
      @juicer_ingredient.destroy
      flash[:notice] = "材料を削除しました"
      redirect_to end_users_juicer_ingredients_path
    else
      if @juicer_ingredient.update(juicer_ingredient_params)
        flash[:notice] = "個数を変更しました"
        redirect_to end_users_juicer_ingredients_path
      else
        @juicer_ingredients = current_end_user.juicer_ingredients
        render "end_users/juicer_ingredients/index"
      end
    end
  end

  def destroy
    JuicerIngredient.find(params[:id]).destroy
    flash[:notice] = "材料を削除しました"
    redirect_to end_users_juicer_ingredients_path
  end

  def destroy_all
    JuicerIngredient.where(end_user_id: current_end_user.id).destroy_all
    flash[:notice] = '全ての材料を削除しました'
    redirect_to request.referer
  end

  private
  def juicer_ingredient_params
    params.require(:juicer_ingredient).permit(:ingredient_id, :amount)
  end
end