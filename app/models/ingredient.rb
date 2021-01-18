class Ingredient < ApplicationRecord
  has_many :juicer_ingredients, dependent: :destroy
  has_many :smoothie_ingredients, dependent: :destroy
  has_many :smoothies, through: :smoothie_ingredients, source: :smoothie
  belongs_to :end_user, foreign_key: "created_by",optional: true

  validates :name, presence: true

  scope :sort_by_used_times_desc, -> { left_joins(:smoothie_ingredients).group(:id)}

  def self.today
    range = Date.today.beginning_of_day..Date.today.end_of_day
    self.where(created_at: range).order(created_at: "DESC")
  end

  def self.filter_by_created_by(user, other, admin, current_end_user_id)
    array = self
    other_end_users_ids = EndUser.where.not(id: current_end_user_id)
    if user == "0"
      array = array.where(created_by: [other_end_users_ids, nil])
    end
    if other == "0"
      array = array.where(created_by: [current_end_user_id, nil])
    end
    if admin == "0"
      array = array.where.not(created_by: nil)
    end
    return array
  end

  def convert_to_mili(vitamin)
    (vitamin.to_f * 1000).round(3)
  end

  def convert_to_micro(vitamin)
    (vitamin.to_f * 1000000).round(3)
  end

end