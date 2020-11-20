class EndUsers::IngredientsController < ApplicationController
  
  def index
    @ingredients = Ingredient.all
  end
  
  def show
    @ingredient = Ingredient.find(params[:id])
    @juicer_ingredient = JuicerIngredient.new
  end
  
end
