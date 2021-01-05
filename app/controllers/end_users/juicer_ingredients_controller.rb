class EndUsers::JuicerIngredientsController < ApplicationController
  before_action :authenticate_end_user!

  def create
    @juicer_ingredient = current_end_user.juicer_ingredients.new(juicer_ingredient_params)
    @ingredient = Ingredient.find(params[:juicer_ingredient][:ingredient_id])
    if params[:juicer_ingredient][:amount].to_i == 0
      flash[:warning] = "数量は半角数字でご入力ください"
      redirect_to ingredient_path(@ingredient) and return
    end
    if current_end_user.juicer_ingredients.find_by(ingredient_id: params[:juicer_ingredient][:ingredient_id]).present?
      juicer_ingredient = current_end_user.juicer_ingredients.find_by(ingredient_id: params[:juicer_ingredient][:ingredient_id])
      juicer_ingredient.amount += params[:juicer_ingredient][:amount].to_i
      juicer_ingredient.save
      flash[:success] = "材料を追加しました"
      redirect_to juicer_ingredients_path
    else
      if @juicer_ingredient.save
        flash[:success] = "材料を追加しました"
        redirect_to juicer_ingredients_path
      else
        render "end_users/ingredients/show"
      end
    end
  end

  def index
    @juicer_ingredients = current_end_user.juicer_ingredients
    @juicer_ingredient = JuicerIngredient.new
  end

  def update
    @juicer_ingredient = JuicerIngredient.find(params[:id])
    @juicer_ingredients = current_end_user.juicer_ingredients
    # 非同期通信した際のビューで必要な変数
    if params[:juicer_ingredient][:amount] == "0"
      @juicer_ingredient.destroy
      flash[:success] = "材料を削除しました"
      redirect_to juicer_ingredients_path
    else
      # 0以外の数量に変更した時
      flash.now[:success] = "数量を変更しました" if @juicer_ingredient.update(juicer_ingredient_params)
      # jsファイルの中でエラーメッセージのエリアの更新も行っているのでvalidatesに引っかかったときのelseで条件分岐は必要ない
    end
  end

  def destroy
    JuicerIngredient.find(params[:id]).destroy
    flash[:success] = "材料を削除しました"
    redirect_to juicer_ingredients_path
  end

  def destroy_all
    JuicerIngredient.where(end_user_id: current_end_user.id).destroy_all
    flash[:success] = '全ての材料を削除しました'
    redirect_to request.referer
  end

  private
  def juicer_ingredient_params
    params.require(:juicer_ingredient).permit(:ingredient_id, :amount)
  end
end