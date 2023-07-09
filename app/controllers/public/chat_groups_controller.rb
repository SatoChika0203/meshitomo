class Public::ChatGroupsController < ApplicationController
  def index
    # @chat_group_users=current_user.chat_group_users
    # @chat_groups=@chat_group_users.each do |chat_group_user|
    #   chat_group_user.chat_group
    # end
    # @chat_groups=ChatGroup.where(recruitment_id: params[:id])
    
     @chat_group_users=current_user.chat_group_users
     @chat_groups=@chat_group_users.chat_group
  end
  
  def show
    @chat_groups=ChatGroup.where(recruitment_id: params[:id])
  end
  
end
