class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.decimal :energy, precision: 12, scale: 9, default: 0.0
      t.decimal :protein, precision: 12, scale: 9, default: 0.0
      t.decimal :carb, precision: 12, scale: 9, default: 0.0
      t.decimal :lipid, precision: 12, scale: 9, default: 0.0
      t.decimal :vitamin_a, precision: 12, scale: 9, default: 0.0
      t.decimal :vitamin_b1, precision: 12, scale: 9, default: 0.0
      t.decimal :vitamin_b2, precision: 12, scale: 9, default: 0.0
      t.decimal :vitamin_b6, precision: 12, scale: 9, default: 0.0
      t.decimal :vitamin_b12, precision: 12, scale: 9, default: 0.0
      t.decimal :vitamin_c, precision: 12, scale: 9, default: 0.0
      t.decimal :vitamin_d, precision: 12, scale: 9, default: 0.0
      t.decimal :vitamin_e, precision: 12, scale: 9, default: 0.0
      t.decimal :vitamin_k, precision: 12, scale: 9, default: 0.0
      t.integer :created_by

      t.timestamps
    end
  end
end
