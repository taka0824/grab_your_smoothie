class HomesController < ApplicationController

  def top
    @all_ranks = Smoothie.joins(:favorites).where(favorites: {created_at: Time.now.all_month}).group(:id).order('count(favorites.smoothie_id) desc').limit(3)
    @new_smoothies = Smoothie.all.order(created_at: "DESC").limit(5)
  end

  def about
  end

end
