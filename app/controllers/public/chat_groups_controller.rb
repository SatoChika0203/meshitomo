class Public::ChatGroupsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @chat_group_users=current_user.chat_group_users
    @chat_groups=ChatGroup.where(id: @chat_group_users.pluck(:chat_group_id)).page(params[:page])
  end
  
  def show
    @chat_group=ChatGroup.find_by(recruitment_id: params[:recruitment_id])
    @chat_group_users=ChatGroupUser.where(chat_group_id: @chat_group.id)
    @recruitment=Recruitment.find(params[:recruitment_id])
    @chats=Chat.where(chat_group_id: @chat_group.id)
    @chats=Chat.where(chat_group_id: @chat_group.id).order(created_at: :desc)
    @chat=Chat.new
  end
  
  def confirm
    @recruitment=Recruitment.find(params[:recruitment_id])
  end
    
  
  def destroy
    chat_group=ChatGroup.find_by(recruitment_id: params[:recruitment_id])
    chat_group.destroy
    redirect_to chat_groups_path
  end
  
end
