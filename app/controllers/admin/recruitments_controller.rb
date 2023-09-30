class Admin::RecruitmentsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @recruitments=Recruitment.all
    @recruitments=Recruitment.all.page(params[:page])
    @users=User.all
  end
  
  def show
    @applications=Application.where(recruitment_id: params[:id])
    # @application=Application.find_by(applicant_id: current_user.id)
    @recruitment=Recruitment.find(params[:id])
    chat_group=ChatGroup.where(recruitment_id: params[:id])
    @chat_group_users=ChatGroupUser.where(chat_group_id: chat_group.ids)
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
  
  def destroy
    @applications=Application.where(recruitment_id: params[:id])
    @recruitment=Recruitment.find(params[:id])
    @chat_group_user=ChatGroupUser.new
    chat_group=ChatGroup.where(recruitment_id: params[:id])
    @chat_group_users=ChatGroupUser.where(chat_group_id: chat_group.ids)

    if @recruitment.destroy
      redirect_to admin_recruitments_path
    else
      render :show
    end
  end
  
  def history
    @user=User.find(params[:user_id])
    @recruitments=Recruitment.where(user_id: params[:user_id])
    @recruitments = Recruitment.all.page(params[:page]).per(5)
  end
  
  private
  
  def recruitment_params
    params.require(:recruitment).permit(:title, :introduction, :schedule, :prefecture, :number_of_people, :recruitment_gender, :deadline, :shop_id)
  end
  
end
