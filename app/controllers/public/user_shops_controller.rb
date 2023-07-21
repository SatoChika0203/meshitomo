class Public::UserShopsController < ApplicationController
  def index

    
    
  end
  
  def create
    shop = Shop.find(params[:shop_id])
    user_shop = current_user.user_shop.new(shop_id: shop.id)
    user_shop.save
    redirect_to user_shop_users_path(shop.user_id)
  end

  def destroy
    shop = Shop.find(params[:shop_id])
    user_shop = current_user.user_shop.find_by(shop_id: shop.id)
    user_shop.destroy
    redirect_to user_shop_users_path(shop.user_id)
  end
end
