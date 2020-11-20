class CreateJuicerIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :juicer_ingredients do |t|
      t.integer :end_user_id
      t.integer :ingredient_id
      t.integer :amount

      t.timestamps
    end
  end
end
