class CreateSmoothieIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :smoothie_ingredients do |t|
      t.integer :smoothie_id
      t.integer :ingredient_id
      t.integer :amount

      t.timestamps
    end
  end
end
