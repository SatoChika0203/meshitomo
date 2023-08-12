class Public::UserShopsController < ApplicationController
  def index
    @shops=current_user.shops.page(params[:page])
    @shops=current_user.shops.order(created_at: :desc).page(params[:page])
    @user=current_user
  end

  # def create
  #   shop = Shop.find(params[:shop_id])
  #   user_shop = current_user.user_shops.new(shop_id: shop.id)
  #   user_shop.save
  #   redirect_to user_user_shops_path(shop.user_id)
  # end

  # def destroy
  #   shop = Shop.find(params[:shop_id])
  #   user_shop = current_user.user_shop.find_by(shop_id: shop.id)
  #   user_shop.destroy
  #   redirect_to user_user_shops_path(current_user.id)
  # end
end
