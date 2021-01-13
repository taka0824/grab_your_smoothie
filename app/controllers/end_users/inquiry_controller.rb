class EndUsers::InquiryController < ApplicationController
  
  def index
    @inquiry = Inquiry.new
  end

  def confirm
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.invalid?
      render :action => 'index'
    end
  end

  def thanks
    @inquiry = Inquiry.new(inquiry_params)
    InquiryMailer.received_email(@inquiry).deliver
  end

  private
  def inquiry_params
    params.require(:inquiry).permit(:name, :message, :email)
  end
end
