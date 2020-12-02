class RemoveEdiblePartAmountFromIngredients < ActiveRecord::Migration[5.2]
  def change
    remove_column :ingredients, :edible_part_amount, :integer
  end
end
