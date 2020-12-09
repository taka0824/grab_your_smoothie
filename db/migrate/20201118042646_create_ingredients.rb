class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.decimal :energy, precision: 13, scale: 9
      t.decimal :protein, precision: 13, scale: 9
      t.decimal :carb, precision: 13, scale: 9
      t.decimal :lipid, precision: 13, scale: 9
      t.decimal :vitamin_a, precision: 13, scale: 9
      t.decimal :vitamin_b1, precision: 13, scale: 9
      t.decimal :vitamin_b2, precision: 13, scale: 9
      t.decimal :vitamin_b6, precision: 13, scale: 9
      t.decimal :vitamin_b12, precision: 13, scale: 9
      t.decimal :vitamin_c, precision: 13, scale: 9
      t.decimal :vitamin_d, precision: 13, scale: 9
      t.decimal :vitamin_e, precision: 13, scale: 9
      t.decimal :vitamin_k, precision: 13, scale: 9
      t.integer :created_by

      t.timestamps
    end
  end
end
