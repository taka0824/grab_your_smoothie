class NotificationMailer < ApplicationMailer

  # def send_when_rule_violation(end_user, contact) #メソッドに対して引数を設定
  #   @end_user = end_user #ユーザー情報
  #   @answer = contact.reply_text #返信内容
  #   mail to: end_user.email, subject: '【サイト名】 お問い合わせありがとうございます'
  # end

  def send_when_rule_violation(end_user)
    @end_user = end_user
    mail to: end_user.email, subject: "コミュニティガイドライン違反のお知らせ(送信専用)"
  end
  
  def send_when_rule_violation_resign(end_user)
    @end_user = end_user
    mail to: end_user.email, subject: "コミュニティガイドライン違反に伴う退会措置のお知らせ(送信専用)"
  end
  
end
