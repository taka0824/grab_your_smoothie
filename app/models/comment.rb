class Comment < ApplicationRecord
  
  include Discard::Model
  default_scope -> { joins(:end_user).merge(EndUser.kept) }
  # .merge(モデル名.スコープ名)でjoin先のスコープを使用することができる
  
  belongs_to :end_user
  belongs_to :smoothie
  has_many :notifications, dependent: :destroy

  validates :content, presence: true
  validates :content, length: { maximum: 100 }

end

