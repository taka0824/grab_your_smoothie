class JuicerIngredient < ApplicationRecord
  belongs_to :end_user
  belongs_to :ingredient

  def self.total_nutrient_to_gram(vitamin)
    array = []
    self.all.each do |juicer_ingredient|
      array << juicer_ingredient.ingredient[vitamin].to_f * juicer_ingredient.amount
    end
    array.sum.floor(3) / 100
  end

  def self.total_nutrient_to_mili(vitamin)
    array = []
    self.all.each do |juicer_ingredient|
      array << juicer_ingredient.ingredient[vitamin].to_f * 1000 * juicer_ingredient.amount
    end
    array.sum.floor(3) / 100
  end

  def self.total_nutrient_to_micro(vitamin)
    array = []
    self.all.each do |juicer_ingredient|
      array << juicer_ingredient.ingredient[vitamin].to_f * 1000000 * juicer_ingredient.amount
    end
    array.sum.floor(3) / 100
  end

end
