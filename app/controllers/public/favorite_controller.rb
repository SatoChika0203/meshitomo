class Public::FavoriteController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @shops=current_user.shops.page(params[:page])
    # @shops.each do |shop|
    #   if shop.chkFlg = "1"
    #   then  @shopsから除外する
    # end
    @shops=current_user.shops.order(created_at: :desc).page(params[:page])
    @user=current_user
  end
  
  def destroy
    favorite_shop=Favorite.find_by(user_id: params[:user_id], shop_id: params[:id])
    favorite_shop.destroy
    redirect_to user_favorite_index_path(current_user.id)
  end
end
