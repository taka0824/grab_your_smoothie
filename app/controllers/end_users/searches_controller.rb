class EndUsers::SearchesController < ApplicationController

  def ingredient_search
    @word = params[:word]
    @ingredients = Ingredient.where('name like ?',"%#{@word}%")
  end
end
