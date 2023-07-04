class Public::ApplicationsController < ApplicationController

def confirm
  @recruitment=Recruitment.find_by(id: params[:recruitment_id])
  @application=Application.new
end

def create
  @recruitment=Recruitment.find_by(id: params[:recruitment_id])
  application=Application.new(application_params)
  # application.save(recruitment_id: @recruitment.id, applicant_id: current_user.id)
  application.recruitment_id=@recruitment.id
  application.applicant_id=current_user.id
  application.save
  # application.save(recruitment_id: params[:recruitment_id], applicant_id: current_user.id)
  redirect_to complete_recruitment_applications_path
end

def complete
  @recruitment=Recruitment.find_by(id: params[:recruitment_id])
end

def history
  @applications=current_user.applications
end

def show
  @recruitment=Recruitment.find_by(id: params[:recruitment_id])
  @application=Application.find_by(recruitment_id: params[:recruitment_id], applicant_id: current_user.id)
end

def cancel
  @recruitment=Recruitment.find_by(id: params[:recruitment_id])
end

def withdraw
  recruitment=Recruitment.find_by(id: params[:recruitment_id])
  # application=Application.find_by(recruitment_id: recruitment.id, applicant_id: current_user.id)
  application=Application.find_by(recruitment_id: params[:recruitment_id], applicant_id: current_user.id)
  application.update(is_valid: false)

  # application.destroy
  redirect_to recruitment_applications_path(recruitment.id)
end

end

private
def application_params
  params.require(:application).permit(:message, :schedule_one, :schedule_two, :schedule_three)
end


