class Admin::RecruitmentsController < ApplicationController
  def index
    @recruitments=Recruitment.all
    @users=User.all
  end
  
  def show
    @recruitment=Recruitment.find(params[:id])
  end
  
  def edit
    @recruitment=Recruitment.find(params[:id])
  end
  
  def update
    @recruitment=Recruitment.find(params[:id])
    if @recruitment.update(recruitment_params)
      redirect_to admin_recruitment_path(@recruitment.id)
      # redirect_toはgetメソッドに働く
    else
      render :edit
    end
  end
  
  private
  
  def recruitment_params
  params.require(:recruitment).permit(:title, :introduction, :schedule_one, :schedule_two, :schedule_three, :prefectures, :number_of_people, :recruitment_gender, :deadline, :is_valid)
  end
  
end
