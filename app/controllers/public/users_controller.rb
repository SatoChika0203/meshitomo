class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update, :confirm, :withdraw]
  before_action :is_deleted_user, only: [:show]


  def show
    @user=User.find(params[:id])
    @recruitments = Recruitment.where(user_id: @user.id)

    @recruitments_male_only=@recruitments.where(recruitment_gender: 0).or(Recruitment.where(recruitment_gender: 2)).page(params[:page])
    @recruitments_female_only=@recruitments.where(recruitment_gender: 1).or(Recruitment.where(recruitment_gender: 2)).page(params[:page])
    @recruitments_anyone=@recruitments.where(recruitment_gender: 2).page(params[:page])

    @recruitments_male_only=@recruitments.where(recruitment_gender: 0).or(Recruitment.where(recruitment_gender: 2)).order(created_at: :desc).page(params[:page])
    @recruitments_female_only=@recruitments.where(recruitment_gender: 1).or(Recruitment.where(recruitment_gender: 2)).order(created_at: :desc).page(params[:page])
    @recruitments_anyone=@recruitments.where(recruitment_gender: 2).order(created_at: :desc).page(params[:page])
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="変更が完了しました！"
      redirect_to user_path(@user.id)
      # redirect_toはgetメソッドに働く
    else
      render :edit
    end
  end

  def confirm
    @user=User.find(params[:id])
  end

  def withdraw
    ActiveRecord::Base.transaction do
    current_user.update(is_deleted: true)  # is_deletedカラムをtrueにupdateする事により、退会状態を作り出す
    current_user.chat_group_users.destroy_all
    current_user.recruitments.update(is_valid: false)
    end
    reset_session
    redirect_to root_path
  end


private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :postal_code, :address, :telephone_number, :email, :encrypted_password, :gender, :prefecture, :introduction, :is_deleted, :image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to recruitments_path
    end
  end

  def is_deleted_user
    user = User.find(params[:id])
    if user.is_deleted == true
      flash[:notice]="このユーザーは退会しました。"
      redirect_to recruitments_path
    end
  end
end
