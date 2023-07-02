class Public::ApplicationsController < ApplicationController

def confirm
  @recruitment=Recruitment.find_by(id: params[:recruitment_id])
  @application=Application.new
end

def create
  @recruitment=Recruitment.find_by(id: params[:recruitment_id])
  application=Application.new(application_params)
  application.save(recruitment_id: @recruitment.id, applicant_id: current_user.id)
  redirect_to complete_recruitment_applications_path
end

def complete
  @recruitment=Recruitment.find_by(id: params[:recruitment_id])
end

def history
end

def show
end

def cancel
end

def destroy
end

end

private
def application_params
  params.require(:application).permit(:message, :schedule_one, :schedule_two, :schedule_three)
end


