class Notification < ApplicationRecord
  
  default_scope -> { order(created_at: "DESC") }
  belongs_to :smoothie, optional: true
  belongs_to :comment, optional: true
  belongs_to :visitor, class_name: "EndUser", foreign_key: "visitor_id"
  belongs_to :visited, class_name: "EndUser", foreign_key: "visited_id"

  def how_long_ago
    if (Time.now - self.created_at) <= 60 * 60
      # 1時間以内なら（60秒 x 60分）
      ((Time.now - self.created_at) / 60).to_i.to_s + "分前"
      # 秒を60で割って分単位に直す
      # .to_iで小数点以下切り捨て
      # .to_sでstring化 + "分前"でstringの文字連結
    elsif (Time.now - self.created_at) <= 60 * 60 * 24
      # 1日以内なら(60秒 x 60分 x 24時間)
      ((Time.now - self.created_at) / 3600).to_i.to_s + "時間前"
      # 秒を60で割って分単位に、さらに分を60で割って時間単位に直す
    elsif (Date.today - self.created_at.to_date) <= 30
      # Date.todayとcreated_at.to_dateの日数での計算なので、日数の差が出力される
      (Date.today - self.created_at.to_date).to_i.to_s + "日前"
    end
  end

end