class Smoothie < ApplicationRecord
    has_many :favorites, dependent: :destroy
    has_many :smoothie_ingredients, dependent: :destroy
    has_many :comments, dependent: :destroy
    belongs_to :end_user
    has_many :ingredients, through: :smoothie_ingredients, source: :ingredient
    has_many :notifications, dependent: :destroy
    attachment :image

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
end