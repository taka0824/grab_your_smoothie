class EndUsers::SearchesController < ApplicationController
  before_action :authenticate_end_user!

  def ingredient_search
    if params[:word] == ""
      redirect_to request.referer
    else
      @word = params[:word]
      @ingredients = Ingredient.where('name like ?',"%#{@word}%").left_joins(:smoothie_ingredients).group(:id).order('count(smoothie_ingredients.ingredient_id) desc')
      @ingredients = Kaminari.paginate_array(@ingredients).page(params[:page]).per(15)
    end
  end

  def recipe_search
    if params[:word] == ""
      redirect_to request.referer
    else
      @word = params[:word]
      @introductions = Smoothie.where('introduction like ?', "%#{@word}%")
      # smoothieテーブルのintroductionからスムージーの検索→取り出したものは全てsmoothieテーブルのレコード
      @ingredients = Ingredient.where('name like ?', "%#{@word}%")
      # ingredientテーブルのnameから材料の検索→取り出したものはingredient, このingredientがもつスムージーを最終的に渡す
      @smoothies = []
      @introductions.each do |i|
        @smoothies << i
      end
      @ingredients.each do |i|
        i.smoothies.each do |s|
          @smoothies << s
        end
      end
      @smoothies = @smoothies.uniq
      @smoothies = Kaminari.paginate_array(@smoothies).page(params[:page]).per(9)
    end
  end

end
