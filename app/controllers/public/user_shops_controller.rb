class Public::UserShopsController < ApplicationController
  def index
    @shops=current_user.shops.where(registration_flg: 0).page(params[:page])
    # @shops.each do |shop|
    #   if shop.chkFlg = "1"
    #   then  @shopsから除外する
    # end
    @shops=current_user.shops.where(registration_flg: 0).order(created_at: :desc).page(params[:page])
    @user=current_user
  end
  
  # def destroy
  #   shop = Shops.find(prams[:id])
  #   shop.update(chkFlg = "1")
  # end

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
