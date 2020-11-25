class Comment < ApplicationRecord
  belongs_to :end_user
  belongs_to :smoothie

  validates :content, presence: true

end

