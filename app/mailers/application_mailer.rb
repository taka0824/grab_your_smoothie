class ApplicationMailer < ActionMailer::Base
  default from: "Grab Your Smoothie"  #差出人の名前
          # subject: "投稿削除のお知らせ" #メール題名
          # reply_to: ENV['MAIL_USER_NAME'] #差出人のメールアドレス
  layout 'mailer'
  
end

