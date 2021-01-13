class Comment < ApplicationRecord
  belongs_to :end_user
  belongs_to :smoothie
  has_many :notifications, dependent: :destroy

  validates :content, presence: true
  validates :content, length: { maximum: 100 }

  def self.today
    range = Date.today.beginning_of_day..Date.today.end_of_day
    self.where(created_at: range).order(created_at: "DESC")
  end



end

