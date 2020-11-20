class Smoothie < ApplicationRecord
    has_many :favorites, dependent: :destroy
    has_many :smoothie_ingredients, dependent: :destroy
    has_many :comments, dependent: :destroy
    belongs_to :end_user
    attachment :image
    
    def favorited_by?(end_user)
      favorites.where(end_user_id: end_user.id).exists?
    end

end