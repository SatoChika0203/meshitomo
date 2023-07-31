class Public::ChatGroupsController < ApplicationController
  def index
    # @chat_group_users=current_user.chat_group_users
    # @chat_groups=@chat_group_users.each do |chat_group_user|
    #   chat_group_user.chat_group
    # end
    # @chat_groups=ChatGroup.where(recruitment_id: params[:id])
    
    @chat_group_users=current_user.chat_group_users
    @chat_groups=ChatGroup.where(id: @chat_group_users.pluck(:chat_group_id))
  end
  
  def show
    @chat_group=ChatGroup.find_by(recruitment_id: params[:recruitment_id])
    @chat_group_users=ChatGroupUser.where(chat_group_id: @chat_group.id)
    @recruitment=Recruitment.find(params[:recruitment_id])
    @chats=Chat.where(chat_group_id: @chat_group.id)
    @chat=Chat.new
    @chat_pages = Chat.all.page(params[:page]).per(5)
    
    # @chat_data = Chat.all.order(created_at: :desc)
    # @chat_pages = Kaminari.paginate_array(@chat_data).page(params[:page]).per(10)
  end
  
  def confirm
    @recruitment=Recruitment.find(params[:recruitment_id])
  end
    
  
  def destroy
    chat_group=ChatGroup.find_by(recruitment_id: params[:recruitment_id])
    chat_group.destroy
    redirect_to user_path(current_user.id)
  end
  
end
