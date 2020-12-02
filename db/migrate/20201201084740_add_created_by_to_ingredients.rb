class AddCreatedByToIngredients < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredients, :created_by, :integer
  end
end
