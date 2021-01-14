class EndUsers::SmoothiesController < ApplicationController
  before_action :authenticate_end_user!

  def new
    if JuicerIngredient.where(end_user_id: current_end_user.id).empty?
      redirect_to juicer_ingredients_path
    end
    @smoothie = Smoothie.new
    @juicer_ingredients = JuicerIngredient.where(end_user_id: current_end_user)
  end

  def new_smoothies
    @smoothies = Smoothie.all.order(created_at: "DESC").page(params[:page]).per(9)
  end

  def smoothie_ranking
    # @all_ranks = Smoothie.joins(:favorites).where("created_at between '30.days.ago.beginning_of_day' and 'Date.yesterday.end_of_day'").group(:id).order('count(favorites.smoothie_id) desc').limit(9)
    # 上の記述は今月分のいいねだけを対象
    @all_ranks = Smoothie.rank_by_favorite.limit(9)
    # ランキング方法２
    # @all_ranks = Smoothie.find(Favorite.group(:smoothie_id).order('count(smoothie_id) desc').limit(3).pluck(:smoothie_id)
    # Favorite.group(:smoothie_id)⇨いいねテーブルをsmoothie_idでグループ化する
    # order('count(smoothie_id) desc')⇨smoothie_idの数で降順に並べ替え
    # limit(3).pluck(:smoothie_id)⇨　上から3つだけ取り出して、smoothie_idのみを取り出した配列作成
    # find(pluckで作成した配列)⇨idで検索

  end

  def show
    @smoothie = Smoothie.find(params[:id])
  end

  def create
    @smoothie = Smoothie.new(smoothie_params)
    @smoothie.end_user_id = current_end_user.id
    if params[:smoothie][:is_recommended] == "true"
      if current_end_user.smoothies.where(is_recommended: true)
        smoothie = current_end_user.smoothies.where(is_recommended: true)
        smoothie.update(is_recommended: false)
      end
    end
    if @smoothie.save
      current_end_user.juicer_ingredients.each do |smoothie_ingredient|
        ingredient_id = smoothie_ingredient.ingredient.id
        amount = smoothie_ingredient.amount
        SmoothieIngredient.new(smoothie_id: @smoothie.id, ingredient_id: ingredient_id, amount: amount).save
      end
      current_end_user.juicer_ingredients.destroy_all
      flash[:success] = "スムージーレシピを投稿しました"
      redirect_to root_path
    else
      @juicer_ingredients = JuicerIngredient.where(end_user_id: current_end_user)
      render "end_users/smoothies/new"
    end
  end

  def destroy
    smoothie = Smoothie.find(params[:id])
    id = smoothie.end_user_id
    smoothie.destroy
    flash[:success] = "スムージー投稿を削除しました"
    redirect_to recipe_list_end_user_path(id)
  end

  def is_recommended_update
    end_user = Smoothie.find(params[:id]).end_user
    if end_user.smoothies.where(is_recommended: true)
      end_user.smoothies.where(is_recommended: true).update(is_recommended: false)
    end
    smoothie = Smoothie.find(params[:id])
    smoothie.update(is_recommended: true)
    flash[:success] = "おすすめレシピを変更しました"
    redirect_to request.referer
  end

  private

  def smoothie_params
    params.require(:smoothie).permit(:image, :introduction, :is_recommended)
  end

  def image_save(image_file)
    if Rails.env.development?
      file_path = "#{Rails.root}/tmp/uploads/store/#{image_file.id}"
    else
      file_path = "#{Rails.root}/public/uploads/#{image_file.id}"
    end
    image_original = File.open(file_path).read
    rmagick_image = Refile::MiniMagick::Image.from_blob(image_original).first
    rmagick_image.auto_orient!
    rmagick_image.strip!
    image_rotated = rmagick_image.to_blob
    File.open(file_path, mode = "wb") do |f|
      f.write(image_rotated)
    end
  end

end
