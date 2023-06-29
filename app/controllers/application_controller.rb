class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :postal_code, :address, :telephone_number, :gender, :image])
  end
  
  def after_sign_in_path_for(resource)
    flash[:notice]="ようこそ！"
    recruitments_path
  end
  
  def after_sign_up_path_for(resource)
    flash[:notice]="はじめまして！"
    users_path
  end
  
  def after_sign_out_path_for(resource)
    flash[:notice]="また来てくださいね！"
    root_path
  end
  
end
