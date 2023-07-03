class Public::RecruitmentsController < ApplicationController
  
  def new
    @recruitment=Recruitment.new
  end
  
  def create
    @recruitment=Recruitment.new(recruitment_params)
    @recruitment.user_id=current_user.id
    if @recruitment.save
      redirect_to recruitment_path(@recruitment.id)
    else
      render :new
    end
  end
  
  def index
    @recruitments=Recruitment.all
  end
  
  def show
    @application=Application.find_by(recruitment_id: params[:id], applicant_id: current_user.id)
    @applications=Application.where(recruitment_id: params[:id])
    
    @recruitment=Recruitment.find(params[:id])
    if DateTime.now.after? @recruitment.deadline 
      @recruitment.is_valid.update(is_valid: false)
      # @recruitment.is_valid==false
    end
    # @application=Application.find_by(recruitment_id: @recruitment.id, applicant_id: current_user.id)
  end
  
  def edit
    @recruitment=Recruitment.find(params[:id])
  end
  
  def update
    @recruitment=Recruitment.find(params[:id])
    if @recruitment.update(recruitment_params)
      redirect_to recruitment_path(@recruitment.id)
    else
      render :edit
    end    
  end
  
  def destroy
    recruitment=Recruitment.find(params[:id])
    recruitment.destroy
    redirect_to recruitments_path
  end
  
  def confirm
  end
  
  def history
    @recruitments=current_user.recruitments
  end
  
  private
  
  def recruitment_params
    params.require(:recruitment).permit(:title, :introduction, :schedule_one, :schedule_two, :schedule_three, :prefectures, :number_of_people, :recruitment_gender, :deadline)
  end
end
