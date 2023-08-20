class Public::ApplicationsController < ApplicationController
before_action :authenticate_user!
# before_action :is_matching_login_user, only: [:cancel, :withdraw]

def confirm
  @recruitment=Recruitment.find_by(id: params[:recruitment_id])
  @application=Application.new
end

def create
  @recruitment=Recruitment.find_by(id: params[:recruitment_id])
  if @recruitment.applications.find_by(applicant_id: current_user.id).blank?
    application=Application.new(application_params)
  # application.save(recruitment_id: @recruitment.id, applicant_id: current_user.id)
    application.recruitment_id=@recruitment.id
    application.applicant_id=current_user.id
    application.save
    redirect_to complete_recruitment_applications_path
  elsif @recruitment.applications.find_by(applicant_id: current_user.id).is_valid==false
    application=@recruitment.applications.find_by(applicant_id: current_user.id)
    application.update(application_params)
    application.update(is_valid: true)
    redirect_to complete_recruitment_applications_path
  else
    render :confirm
  end
end

def complete
  @recruitment=Recruitment.find_by(id: params[:recruitment_id])
end

def history
  @applications=current_user.applications.page(params[:page])
  @applications=current_user.applications.order(created_at: :desc).page(params[:page])
end

def show
  @recruitment=Recruitment.find_by(id: params[:recruitment_id])
  @application=Application.find_by(recruitment_id: params[:recruitment_id], applicant_id: current_user.id)
end

def cancel
  @recruitment=Recruitment.find_by(id: params[:recruitment_id])
end

def withdraw
  # application=Application.find_by(recruitment_id: recruitment.id, applicant_id: current_user.id)
  application=Application.find_by(recruitment_id: params[:recruitment_id], applicant_id: current_user.id)
  # application.update(is_valid: false)

  application.update(is_valid: false)
  flash[:notice]="応募のキャンセルが完了しました。"
  redirect_to history_applications_path
  # redirect_to recruitment_applications_path(recruitment.id)
end



private
  def application_params
    params.require(:application).permit(:message, :schedule_one, :schedule_two, :schedule_three)
  end

  # def is_matching_login_user
  #   recruitment=Recruitment.find_by(id: params[:recruitment_id])
  #   unless recruitment.applicant_ids == current_user.id
  #     redirect_to recruitments_path
  #   end
  # end
  
end

