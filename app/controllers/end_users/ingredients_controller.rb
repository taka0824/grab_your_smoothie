class EndUsers::IngredientsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :convert_nutrients_to_gram_per_100_gram, only: [:create]

  def index
    frequent_ingredients = Ingredient.joins(:smoothie_ingredients).group(:id).order('count(smoothie_ingredients.ingredient_id) desc')
    all_ingredients = Ingredient.all
    @ingredients = []
    frequent_ingredients.each do |f|
      @ingredients << f
    end
    all_ingredients.each do |a|
      @ingredients << a
    end
    @ingredients = @ingredients.uniq
    @ingredients = Kaminari.paginate_array(@ingredients).page(params[:page]).per(15)
  end

  def show
    @ingredient = Ingredient.find(params[:id])
    @juicer_ingredient = JuicerIngredient.new
  end

  def new
    @ingredient = Ingredient.new
  end

  def confirm
    @ingredient = Ingredient.new(ingredient_params)
    @gram = params[:ingredient][:gram]
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      flash[:notice] = "材料を追加しました"
      redirect_to end_users_ingredient_path(@ingredient)
    end
  end

  private
  def ingredient_params
    params.require(:ingredient).permit(:name,:edible_part_amount,:energy,:protein,:carb,:lipid,:vitamin_a,:vitamin_b1,:vitamin_b2,:vitamin_b6,:vitamin_b12,:vitamin_c,:vitamin_d,:vitamin_e,:vitamin_k)
  end

  def convert_nutrients_to_gram_per_100_gram
    params[:ingredient][:energy] = (params[:ingredient][:energy].to_f) * (100 / (params[:ingredient][:gram].to_f))
    params[:ingredient][:protein] = (params[:ingredient][:protein].to_f) * (100 / (params[:ingredient][:gram].to_f))
    params[:ingredient][:carb] = (params[:ingredient][:carb].to_f) * (100 / (params[:ingredient][:gram].to_f))
    params[:ingredient][:lipid] = (params[:ingredient][:lipid].to_f) * (100 / (params[:ingredient][:gram].to_f))
    params[:ingredient][:vitamin_b1] = (params[:ingredient][:vitamin_b1].to_f) * (100 / (params[:ingredient][:gram].to_f)) / 1000
    params[:ingredient][:vitamin_b2] = (params[:ingredient][:vitamin_b2].to_f) * (100 / (params[:ingredient][:gram].to_f)) / 1000
    params[:ingredient][:vitamin_b6] = (params[:ingredient][:vitamin_b6].to_f) * (100 / (params[:ingredient][:gram].to_f)) / 1000
    params[:ingredient][:vitamin_c] = (params[:ingredient][:vitamin_c].to_f) * (100 / (params[:ingredient][:gram].to_f)) / 1000
    params[:ingredient][:vitamin_e] = (params[:ingredient][:vitamin_e].to_f) * (100 / (params[:ingredient][:gram].to_f)) / 1000
    params[:ingredient][:vitamin_a] = (params[:ingredient][:vitamin_a].to_f) * (100 / (params[:ingredient][:gram].to_f)) / 1000000
    params[:ingredient][:vitamin_b12] = (params[:ingredient][:vitamin_b12].to_f) * (100 / (params[:ingredient][:gram].to_f)) / 1000000
    params[:ingredient][:vitamin_d] = (params[:ingredient][:vitamin_d].to_f) * (100 / (params[:ingredient][:gram].to_f)) / 1000000
    params[:ingredient][:vitamin_k] = (params[:ingredient][:vitamin_k].to_f) * (100 / (params[:ingredient][:gram].to_f)) / 1000000
  end

end
