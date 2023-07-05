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
    @applications=Application.where(recruitment_id: params[:id])
    @recruitment=Recruitment.find(params[:id])
    @chat_group_user=ChatGroupUser.new
    if DateTime.now.after? @recruitment.deadline 
      @recruitment.is_valid.update(is_valid: false)
      # @recruitment.is_valid==false
    end
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
    @chat_group_user=ChatGroupUser.new(chat_group_user_params)
    
    
  end
  
  def history
    @recruitments=current_user.recruitments
  end
  
  private
  
  def recruitment_params
    params.require(:recruitment).permit(:title, :introduction, :schedule_one, :schedule_two, :schedule_three, :prefectures, :number_of_people, :recruitment_gender, :deadline)
  end
  
  def chat_group_user_params
     params.require(:chat_group_user).permit(:user_id)
  end
end
