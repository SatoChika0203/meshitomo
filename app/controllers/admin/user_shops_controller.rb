class Admin::UserShopsController < ApplicationController
  def index
    @user=User.find(params[:user_id])
    @shops=Shop.where(user_id: @user.id)
  end  
end
