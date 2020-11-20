class CreateNutrients < ActiveRecord::Migration[5.2]
  def change
    create_table :nutrients do |t|
      t.string :name
      t.text :effect
      t.decimal :recommended_amount, precision: 12, scale: 9

      t.timestamps
    end
  end
end
