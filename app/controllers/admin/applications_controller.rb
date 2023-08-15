class Admin::ApplicationsController < ApplicationController
  before_action :authenticate_admin!
  
  def history
    @user=User.find(params[:user_id])
    @applications=Application.where(applicant_id: params[:user_id])
    @applications = Application.all.page(params[:page]).per(5)
  end
  
  def show
    @recruitment=Recruitment.find_by(id: params[:recruitment_id])
    @application=Application.find_by(recruitment_id: params[:recruitment_id], applicant_id: params[:user_id])
  end
  
  def destroy
     recruitment=Recruitment.find_by(id: params[:recruitment_id])
     recruitment.destroy
     redirect_to history_admin_user_applications_path(recruitment.applicant.id)
  end
end
