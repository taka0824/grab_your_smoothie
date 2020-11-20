class EndUsers::FavoritesController < ApplicationController

  def create
    current_end_user.favorites.new(smoothie_id: params[:smoothy_id]).save
    redirect_to request.referer
  end

  def destroy
    smoothie = Smoothie.find(params[:smoothy_id])
    smoothie.favorites.find_by(end_user_id: current_end_user.id).destroy
    redirect_to request.referer
  end

end
