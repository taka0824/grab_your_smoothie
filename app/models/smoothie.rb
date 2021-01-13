class Smoothie < ApplicationRecord
    has_many :favorites, dependent: :destroy
    has_many :smoothie_ingredients, dependent: :destroy
    has_many :comments, dependent: :destroy
    belongs_to :end_user
    has_many :ingredients, through: :smoothie_ingredients, source: :ingredient
    has_many :notifications, dependent: :destroy
    attachment :image

    validates :introduction, length: { maximum: 75 }

    def self.rank_with_favorite
      joins(:favorites).group(:id).order("count(favorites.smoothie_id) desc")
    end
    
    def self.today
      range = Date.today.beginning_of_day..Date.today.end_of_day
      self.where(created_at: range)
    end

    def favorited_by?(end_user)
      favorites.where(end_user_id: end_user.id).exists?
    end

    def create_notification_like(current_end_user)
      temp = Notification.where(["visitor_id = ? and visited_id = ? and smoothie_id = ? and action = ?", current_end_user.id, end_user_id, id, 'favorite'])
      if temp.blank?
        notification = current_end_user.active_notifications.new(
          smoothie_id: id,
          visited_id: end_user_id,
          action: "favorite"
          )
          if notification.visitor_id == notification.visited_id
            notification.checked = true
          end
          notification.save
      end
    end

    def create_notification_comment(current_end_user, comment_id)
      temp_ids = Comment.select(:end_user_id).where(smoothie_id: id).where.not(end_user_id: current_end_user.id).distinct
      temp_ids.each do |temp_id|
        save_notification_comment(current_end_user, comment_id, temp_id.end_user_id)
      end
      save_notification_comment(current_end_user, comment_id, end_user_id)
    end

    def save_notification_comment(current_end_user, comment_id, visited_id)
      notification = current_end_user.active_notifications.new(
        smoothie_id: id,
        comment_id: comment_id,
        visited_id: visited_id,
        action:  "comment"
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save
    end

    def how_long_ago
      if (Time.now - self.created_at) <= 60 * 60
        ((Time.now - self.created_at) / 60).to_i.to_s + "分前"
      elsif (Time.now - self.created_at) <= 60 * 60 * 24
        ((Time.now - self.created_at) / 3600).to_i.to_s + "時間前"
      elsif (Date.today - self.created_at.to_date) <= 30
        (Date.today - self.created_at.to_date).to_i.to_s + "日前"
      end
    end

end