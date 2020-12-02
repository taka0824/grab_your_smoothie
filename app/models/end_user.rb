class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :juicer_ingredients, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_smoothies, through: :favorites, source: :smoothie
  # エンドユーザーからfavoriteしたsmoothie一覧を持ってくる時に必要な記述
  has_many :smoothies, class_name: 'Smoothie', dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :in_juicer_ingredients, through: :juicer_ingredients, source: :ingredient
  has_many :active_notifications, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy
  has_many :ingredients, foreign_key: "created_by", dependent: :destroy

  validates :name, presence: true

  def active_for_authentication?
    super && (self.is_deleted == false)
  end

  scope :active, -> { where(is_deleted:false) }

end
