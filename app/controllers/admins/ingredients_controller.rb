class Admins::IngredientsController < ApplicationController
  before_action :authenticate_admin!
  before_action :check_data_type, only: [:confirm, :update]
  before_action :convert_nutrients_to_gram_per_100_gram, only: [:create, :update]


  def index
    @ingredients = Ingredient.all.order(created_at: "DESC").page(params[:page]).per(15)
  end

  def todays_ingredients
    @ingredients = Ingredient.today.page(params[:page]).per(15)
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
    if (/\A[1-9]\d{0,3}((\.)([1-9]|\d[1-9]|\d{2}[1-9]))?\z/ =~ params[:ingredient][:gram]) != 0 || params[:ingredient][:name] == ""
      flash.now[:warning] = "材料名と〜グラムあたりの栄養素量欄(半角数字)を必ず入力してください"
      @ingredient = Ingredient.new(ingredient_params)
      render "admins/ingredients/new"
    end
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      flash[:success]  = "材料を作成しました"
      redirect_to admins_ingredients_path
    end
  end

  def destroy
    ingredient = Ingredient.find(params[:id])
    ingredient.destroy
    if ingredient.created_by != nil
      @end_user = ingredient.end_user
      @end_user.rule_violation_number += 1
      @end_user.save
      NotificationMailer.send_when_rule_violation(@end_user).deliver if @end_user.rule_violation_number < 5
      @end_user.rule_violation_delete_process if @end_user.rule_violation_number == 5
    end
    flash[:success] = "材料を削除しました"
    redirect_to admins_ingredients_path
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    if params[:ingredient][:gram].to_f == 0.0 || params[:ingredient][:name] == ""
      flash[:warning] = "材料名と〜グラムあたりの栄養素量欄(半角数字)は必ず入力してください"
      redirect_to admins_ingredient_path(@ingredient) and return
    end
    if @ingredient.update(ingredient_params)
      flash[:success] = "材料情報を変更しました"
      redirect_to request.referer
    end
  end

  private
  def ingredient_params
    params.require(:ingredient).permit(:name,:energy,:protein,:carb,:lipid,:vitamin_a,:vitamin_b1,:vitamin_b2,:vitamin_b6,:vitamin_b12,:vitamin_c,:vitamin_d,:vitamin_e,:vitamin_k)
  end

  def detect_string(nutrient)
    (/\A\d{0,4}((\.)([0-9]|\d[1-9]|\d{1,2}[1-9]|))?\z/ =~ nutrient) != 0
  end

  def check_data_type
    redirect_to new_admins_ingredient_path and return if !params[:ingredient]
    nutrients = params[:ingredient].select {|nut| ['energy', 'protein', 'carb', 'lipid', 'vitamin_a', 'vitamin_b1', 'vitamin_b2','vitamin_b6','vitamin_b12', 'vitamin_c', 'vitamin_d', 'vitamin_e', 'vitamin_k'].any? {|v| v == nut }}
    # parameterで受け取った値の中でeach文で使いたい値を配列にしている
    nutrients.each do |nutrient|
      if detect_string(nutrient[1])
        # stringだった時下を通る　eachに渡すnutrientの値はこの時点で配列（配列の中に配列）であるため、配列nutrientの中のどの値を使うのか[] で指定している。配列は左から0,1,2,,,
        if params[:confirm] == "追加"
          @ingredient = Ingredient.new(ingredient_params)
          @gram = params[:ingredient][:gram]
          flash.now[:warning] = "数値は半角数字でご入力ください"
          return render "admins/ingredients/new"
        else
          flash[:warning] = "数値は半角数字でご入力ください"
          return redirect_to request.referer
        end
      end
    end
  end

  def convert_nutrients_to_gram_per_100_gram
      if params[:createback] == "修正する"
        @ingredient = Ingredient.new(ingredient_params)
        @gram = params[:ingredient][:gram]
        return render "admins/ingredients/new"
      else
        params[:ingredient][:energy] = (params[:ingredient][:energy].to_f) * (100 / (params[:ingredient][:gram].to_f))
        params[:ingredient][:protein] = (params[:ingredient][:protein].to_f) * (100 / (params[:ingredient][:gram].to_f))
        params[:ingredient][:carb] = (params[:ingredient][:carb].to_f) * (100 / (params[:ingredient][:gram].to_f))
        params[:ingredient][:lipid] = (params[:ingredient][:lipid].to_f) * (100 / (params[:ingredient][:gram].to_f))
        params[:ingredient][:vitamin_a] = (params[:ingredient][:vitamin_a].to_f) * (100 / (params[:ingredient][:gram].to_f)) / 1000000
        params[:ingredient][:vitamin_b1] = (params[:ingredient][:vitamin_b1].to_f) * (100 / (params[:ingredient][:gram].to_f)) / 1000
        params[:ingredient][:vitamin_b2] = (params[:ingredient][:vitamin_b2].to_f) * (100 / (params[:ingredient][:gram].to_f)) / 1000
        params[:ingredient][:vitamin_b6] = (params[:ingredient][:vitamin_b6].to_f) * (100 / (params[:ingredient][:gram].to_f)) / 1000
        params[:ingredient][:vitamin_b12] = (params[:ingredient][:vitamin_b12].to_f) * (100 / (params[:ingredient][:gram].to_f)) / 1000000
        params[:ingredient][:vitamin_c] = (params[:ingredient][:vitamin_c].to_f) * (100 / (params[:ingredient][:gram].to_f)) / 1000
        params[:ingredient][:vitamin_d] = (params[:ingredient][:vitamin_d].to_f) * (100 / (params[:ingredient][:gram].to_f)) / 1000000
        params[:ingredient][:vitamin_e] = (params[:ingredient][:vitamin_e].to_f) * (100 / (params[:ingredient][:gram].to_f)) / 1000
        params[:ingredient][:vitamin_k] = (params[:ingredient][:vitamin_k].to_f) * (100 / (params[:ingredient][:gram].to_f)) / 1000000
      end
  end

end
