class Admin::UserShopsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @user=User.find(params[:user_id])
    @shops=Shop.where(user_id: @user.id).page(params[:page])
    @shops=Shop.where(user_id: @user.id).order(created_at: :desc).page(params[:page])
  end  
  
  def destroy
  end
end
