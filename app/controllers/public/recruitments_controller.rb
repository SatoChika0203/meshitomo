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
      # @recruitment.is_valid.update(is_valid: false)
      @recruitment.is_valid==false
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
    @chat_group = ChatGroup.new(recruitment_id: params[:id])
    params[:chat_group_user][:user_ids].each do |user_id|
      @chat_group.chat_group_users << ChatGroupUser.new(user_id: user_id)
    end
  end

  def generate
    user_ids = params[:chat_group][:user_ids].split(',').map(&:to_i)
    ActiveRecord::Base.transaction do
      Recruitment.find(params[:id]).update(is_valid: false)
      Application.where(recruitment_id: params[:id]).update_all(is_valid: false)
      Application.where(recruitment_id: params[:id], applicant_id: user_ids).update_all(is_approval: true)
      @chat_group = ChatGroup.new(recruitment_id: params[:id])
      @chat_group.chat_group_users = user_ids.map do |user_id| ChatGroupUser.new(user_id: user_id) end
      @chat_group.save
    end
    redirect_to  complete_recruitments_path
  end

  def history
    @recruitments=current_user.recruitments
  end
  
  def complete
  end

  private

  def recruitment_params
    params.require(:recruitment).permit(:title, :introduction, :schedule_one, :schedule_two, :schedule_three, :prefectures, :number_of_people, :recruitment_gender, :deadline)
  end

  def chat_group_user_params
     params.permit(:user_id)
          # params.require(:chat_group_users).permit(:user_id, keys: [:applicant_id[]])
  end
end
