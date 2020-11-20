class Admins::IngredientsController < ApplicationController
  before_action :convert_to_gram, only: [:create, :update]

  def index
    @ingredients = Ingredient.all
  end

  def show
    @ingredient = Ingredient.find(params[:id])
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    @ingredient.save
    redirect_to admins_ingredients_path
  end

  def destroy
    Ingredient.find(params[:id]).destroy
    redirect_to admins_ingredients_path
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    @ingredient.update(ingredient_params)
    redirect_to request.referer
  end

  private
  def ingredient_params
    params.require(:ingredient).permit(:name,:image,:edible_part_amount,:energy,:protein,:carb,:lipid,:vitamin_a,:vitamin_b1,:vitamin_b2,:vitamin_b6,:vitamin_b12,:vitamin_c,:vitamin_d,:vitamin_e,:vitamin_k)
  end

  def convert_to_gram
    params[:ingredient][:vitamin_b1] = params[:ingredient][:vitamin_b1].to_f / 1000
    params[:ingredient][:vitamin_b2] = params[:ingredient][:vitamin_b2].to_f / 1000
    params[:ingredient][:vitamin_b6] = params[:ingredient][:vitamin_b6].to_f / 1000
    params[:ingredient][:vitamin_c] = params[:ingredient][:vitamin_c].to_f / 1000
    params[:ingredient][:vitamin_e] = params[:ingredient][:vitamin_e].to_f / 1000
    params[:ingredient][:vitamin_a] = params[:ingredient][:vitamin_a].to_f / 1000000
    params[:ingredient][:vitamin_b12] = params[:ingredient][:vitamin_b12].to_f / 1000000
    params[:ingredient][:vitamin_d] = params[:ingredient][:vitamin_d].to_f / 1000000
    params[:ingredient][:vitamin_k] = params[:ingredient][:vitamin_k].to_f / 1000000
  end

end
