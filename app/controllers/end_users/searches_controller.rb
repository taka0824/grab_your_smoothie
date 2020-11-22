class EndUsers::SearchesController < ApplicationController
  before_action :authenticate_end_user!
  def ingredient_search
    @word = params[:word]
    @ingredients = Ingredient.where('name like ?',"%#{@word}%")
  end
  
  def recipe_search
    @word = params[:word]
    @smoothies = Smoothie.where('introduction like ?', "%#{@word}%")
    # 材料からの検索機能の追加が必要
  end
end
