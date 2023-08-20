class Admin::FavoriteController < ApplicationController
  def index
    @user=User.find(params[:user_id])
    @shops=Favorite.where(user_id: @user.id).page(params[:page])
    @shops=Favorite.where(user_id: @user.id).order(created_at: :desc).page(params[:page])
  end

  def destroy
    favorite_shop=Favorite.find_by(user_id: params[:user_id], shop_id: params[:id])
    favorite_shop.destroy
    redirect_to admin_user_favorite_index_path(favorite_shop.user.id)
  end
end
