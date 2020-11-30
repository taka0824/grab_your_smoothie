class Notification < ApplicationRecord
  default_scope -> { order(created_at: "DESC") }
  belongs_to :smoothie, optional: true
  belongs_to :comment, optional: true
  belongs_to :visitor, class_name: "EndUser", foreign_key: "visitor_id"
  belongs_to :visited, class_name: "EndUser", foreign_key: "visited_id"

  def how_long_ago
    if (Time.now - self.created_at) <= 60 * 60
      ((Time.now - self.created_at) / 60).to_i.to_s + "分前"
    elsif (Time.now - self.created_at) <= 60 * 60 * 24
      ((Time.now - self.created_at) / 3600).to_i.to_s + "時間前"
    elsif (Date.today - self.created_at.to_date) <= 30
      (Date.today - self.created_at.to_date).to_i.to_s + "日前"
    end
  end

  # def action_detail(current_end_user)
  #   case action
  #     when "comment" then
  #       if smoothie.end_user.id == current_end_user.id
  #         link_to "あなたの投稿", new_end_users_smoothy_comment_path(smoothie_id)
  #           + "にコメントしました"
  #       else
  #         link_to "smoothie.end_user.nameさんの投稿", new_end_users_smoothy_comment_path(smoothie_id)
  #           + "にコメントしました"
  #       end
  #     when "favorite" then
  #       byebug
  #       link_to "あなたの投稿", end_users_smoothy_path(smoothie_id)
  #       + "をお気に入りしました"
  #   end
  # end

end