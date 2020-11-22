class JuicerIngredient < ApplicationRecord
  belongs_to :end_user
  belongs_to :ingredient

  def self.total_nutrient_to_gram(vitamin)
    array = []
    self.all.each do |juicer_ingredient|
      array << (juicer_ingredient.ingredient[vitamin].to_f / 100) * juicer_ingredient.amount
    end
    array.sum.round(3)
  end

  def self.total_nutrient_to_mili(vitamin)
    array = []
    self.all.each do |juicer_ingredient|
      array << (juicer_ingredient.ingredient[vitamin].to_f / 100 * 1000) * juicer_ingredient.amount
    end
    array.sum.round(3)
  end

  def self.total_nutrient_to_micro(vitamin)
    array = []
    self.all.each do |juicer_ingredient|
      array << (juicer_ingredient.ingredient[vitamin].to_f / 100 * 1000000) * juicer_ingredient.amount
    end
    array.sum.round(3)
  end

end
