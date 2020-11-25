class ChangeIngredientColumnDefault < ActiveRecord::Migration[5.2]
  
  def change
    change_column :ingredients, :energy, :decimal, default: 0.0
    change_column :ingredients, :protein, :decimal, default: 0.0
    change_column :ingredients, :carb, :decimal, default: 0.0
    change_column :ingredients, :lipid, :decimal, default: 0.0
    change_column :ingredients, :vitamin_a, :decimal, default: 0.0
    change_column :ingredients, :vitamin_b1, :decimal, default: 0.0
    change_column :ingredients, :vitamin_b2, :decimal, default: 0.0
    change_column :ingredients, :vitamin_b6, :decimal, default: 0.0
    change_column :ingredients, :vitamin_b12, :decimal, default: 0.0
    change_column :ingredients, :vitamin_c, :decimal, default: 0.0
    change_column :ingredients, :vitamin_d, :decimal, default: 0.0
    change_column :ingredients, :vitamin_e, :decimal, default: 0.0
    change_column :ingredients, :vitamin_k, :decimal, default: 0.0
  end
end
