class Public::ReviewsController < ApplicationController
  def index
    @user=User.find(params[:user_id])
    @recruitments = Recruitment.where(user_id: @user.id)

    @recruitments_male_only=Recruitment.where(recruitment_gender: 0, user_id: @user.id).or(Recruitment.where(recruitment_gender: 2, user_id: @user.id)).page(params[:page])
    @recruitments_female_only=Recruitment.where(recruitment_gender: 1, user_id: @user.id).or(Recruitment.where(recruitment_gender: 2, user_id: @user.id)).page(params[:page])
    @recruitments_anyone=Recruitment.where(recruitment_gender: 2, user_id: @user.id).page(params[:page])

    @recruitments_male_only=Recruitment.where(recruitment_gender: 0, user_id: @user.id).or(Recruitment.where(recruitment_gender: 2, user_id: @user.id)).order(created_at: :desc).page(params[:page])
    @recruitments_female_only=Recruitment.where(recruitment_gender: 1, user_id: @user.id).or(Recruitment.where(recruitment_gender: 2, user_id: @user.id)).order(created_at: :desc).page(params[:page])
    @recruitments_anyone=Recruitment.where(recruitment_gender: 2, user_id: @user.id).order(created_at: :desc).page(params[:page])
  end
  
end
