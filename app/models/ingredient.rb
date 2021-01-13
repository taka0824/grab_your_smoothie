class Ingredient < ApplicationRecord
  has_many :juicer_ingredients, dependent: :destroy
  has_many :smoothie_ingredients, dependent: :destroy
  has_many :smoothies, through: :smoothie_ingredients, source: :smoothie
  belongs_to :end_user, foreign_key: "created_by",optional: true

  validates :name, presence: true

  def self.today
    range = Date.today.beginning_of_day..Date.today.end_of_day
    self.where(created_at: range).order(created_at: "DESC")
  end


  def convert_to_mili(vitamin)
    (vitamin.to_f * 1000).round(3)
  end

  def convert_to_micro(vitamin)
    (vitamin.to_f * 1000000).round(3)
  end

end