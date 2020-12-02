class EndUsers::FavoritesController < ApplicationController
  before_action :authenticate_end_user!
  def create
    @smoothie = Smoothie.find(params[:smoothy_id])
    if current_end_user.favorites.new(smoothie_id: params[:smoothy_id]).save
      flash.now[:success] = "いいねしました"
      @smoothie.create_notification_like(current_end_user)
      # 通知作成
    end
  end

  def destroy
    @smoothie = Smoothie.find(params[:smoothy_id])
    if @smoothie.favorites.find_by(end_user_id: current_end_user.id).destroy
      flash.now[:success] = "いいねを取り消しました"
    end
  end

end
