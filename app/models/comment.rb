class Comment < ApplicationRecord
  belongs_to :end_user
  belongs_to :smoothie
  has_many :notifications, dependent: :destroy

  validates :content, presence: true
  validates :content, length: { maximum: 100 }

end

