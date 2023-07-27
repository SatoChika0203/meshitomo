class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :confirm, :withdraw]

  def index
    @users=User.all
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
    @user.update(user_params)
    redirect_to user_path(@user.id)
      # redirect_toはgetメソッドに働く
    # else
    #   render :edit
    # end
  end

  def confirm
    @user=User.find(params[:id])
  end

  def withdraw
    current_user.update(is_deleted: true)
    # is_deletedカラムをtrueにupdateする事により、退会状態を作り出す
    reset_session
    redirect_to root_path
  end


  private

  def user_params
  params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :postal_code, :address, :telephone_number, :email, :encrypted_password, :gender, :prefectures, :introduction, :is_deleted, :image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(user.id)
    end
  end
end
