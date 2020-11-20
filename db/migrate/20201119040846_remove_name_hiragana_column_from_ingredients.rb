class RemoveNameHiraganaColumnFromIngredients < ActiveRecord::Migration[5.2]
    def change
      remove_column :ingredients, :name_hiragana, :string
    end
end