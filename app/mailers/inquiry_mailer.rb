class InquiryMailer < ApplicationMailer
  
  def received_email(inquiry)
    @inquiry = inquiry
    mail(
      subject:  'お問い合わせを承りました',
      from: ENV['MAIL_USER_NAME'],
      to:   ENV['PRIVATE_MAIL_ADDRESS']
    )
  end
  
end
