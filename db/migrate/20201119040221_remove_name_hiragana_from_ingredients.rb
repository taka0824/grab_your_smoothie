class RemoveNameHiraganaFromIngredients < ActiveRecord::Migration[5.2]
  def change
    remove_column :ingredients, :name_kanji_string, :string
  end
  def change
    remove_column :ingredients, :name_hiragana_string, :string
  end
end
