class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include Discard::Model
  default_scope -> { kept }

  def remember_me
    true
  end

  has_many :juicer_ingredients, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_smoothies, through: :favorites, source: :smoothie
  # has_many :favorited_smoothies, -> { order('favorites.created_at DESC') }, through: :favorites, source: :smoothie
  # 上記の記述の場合end_userから呼び出すfavorited_smoothiesが全て指定したorder順となる
  has_many :smoothies, class_name: 'Smoothie', dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :in_juicer_ingredients, through: :juicer_ingredients, source: :ingredient
  has_many :active_notifications, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy
  has_many :ingredients, foreign_key: "created_by", dependent: :destroy

  validates :name, presence: true

  def active_for_authentication?
    super && (self.discarded_at == nil)
  end

end
