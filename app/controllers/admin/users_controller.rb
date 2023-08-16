class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @users=User.all
    @users=User.all.page(params[:page])
  end
  
  def show
    @user=User.find(params[:id])
    @recruitments = Recruitment.where(user_id: @user.id)
  end
  
  def edit
    @user=User.find(params[:id])
  end  
  
  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user.id)
      # redirect_toはgetメソッドに働く
    else
      render :edit
    end
  end
  
  def destroy
    user=User.find(params[:id])
    user.destroy
    redirect_to admin_users_path
  end
  
  private
  
  def user_params
  params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :postal_code, :address, :telephone_number, :email, :encrypted_password, :gender, :prefecture, :introduction, :is_deleted, :image)
  end
  
end