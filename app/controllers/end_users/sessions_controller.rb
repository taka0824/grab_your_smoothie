# frozen_string_literal: true

class EndUsers::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_end_user, only: [:create]

  protected

  def reject_end_user
    @end_user = EndUser.find_by(email: params[:end_user][:email].downcase)
    if @end_user
      if (@end_user.valid_password?(params[:end_user][:password]) && (@end_user.active_for_authentication? == false))
        flash[:notice] = "退会済みです。"
        redirect_to new_end_user_session_path
      end
    # else
    #   flash[:notice] = "必須項目を入力してください。"
    end
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
