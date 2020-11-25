class Admins::IngredientsController < ApplicationController
  before_action :authenticate_admin!
  before_action :convert_nutrients_to_gram_per_100_gram, only: [:create, :update]
  

  def index
    @ingredients = Ingredient.all.order(created_at: "DESC")
  end

  def todays_ingredients
    range = Date.today.beginning_of_day..Date.today.end_of_day
    @ingredients = Ingredient.where(created_at: range)
  end

  def show
    @ingredient = Ingredient.find(params[:id])
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
      flash[:notice]  = "材料を作成しました"
      redirect_to admins_ingredient_path(@ingredient)
    end
  end

  def destroy
    if Ingredient.find(params[:id]).destroy
      flash[:notice] = "材料を削除しました"
      redirect_to admins_ingredients_path
    end
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    if @ingredient.update(ingredient_params)
      flash[:notice] = "材料情報を変更しました"
      redirect_to request.referer
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
