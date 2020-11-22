class Ingredient < ApplicationRecord
  has_many :juicer_ingredients, dependent: :destroy
  has_many :smoothie_ingredients, dependent: :destroy

  def convert_to_mili(vitamin)
    (vitamin.to_f * 1000).round(3)
  end

  def convert_to_micro(vitamin)
    (vitamin.to_f * 1000000).round(3)
  end

end