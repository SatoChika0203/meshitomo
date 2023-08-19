# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :user_state, only: [:create]
  
  def after_sign_in_path_for(resource)
    flash[:notice]="meshiTomoへようこそ！"
    recruitments_path
  end
  
  # def after_sign_out_path_for(resource)
  #   flash[:notice]="Signed out successfully."
  #   root_path
  # end
  
  protected
  
  def user_state
    @user = User.find_by(email: params[:user][:email])
    return if !@user  # アカウントを取得できなかった場合、このメソッドを終了する
    if @user.valid_password?(params[:user][:password])
      if @user.is_deleted==true
        redirect_to new_user_session_path
      end
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
