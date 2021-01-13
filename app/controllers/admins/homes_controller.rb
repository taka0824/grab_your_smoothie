class Admins::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @smoothies = Smoothie.today
    @comments = Comment.today
    @ingredients = Ingredient.today
  end

end
