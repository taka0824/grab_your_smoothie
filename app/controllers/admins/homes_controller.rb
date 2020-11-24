class Admins::HomesController < ApplicationController

  def top
    range = Date.today.beginning_of_day..Date.today.end_of_day
    @smoothies = Smoothie.where(created_at: range)
    @comments = Comment.where(created_at: range)
    @ingredients = Ingredient.where(created_at: range)
  end

end
