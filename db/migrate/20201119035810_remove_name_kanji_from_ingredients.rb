class RemoveNameKanjiFromIngredients < ActiveRecord::Migration[5.2]
  def change
    remove_column :ingredients, :name_kanji, :string
  end
  def change
    remove_column :ingredients, :name_hiragana, :string
  end
  def change
    rename_column :ingredients, :name_katakana, :name
  end
end
