class RemoveColumnFromIngredients < ActiveRecord::Migration[5.2]
  def change
    remove_column :ingredients, :name_hiragana, :string
  end
  def change
    remove_column :ingredients, :name_kanji, :string
  end
end
