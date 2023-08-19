class Public::ChatsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @chat=current_user.chats.new(chat_params)
    @chat.save
    redirect_to recruitment_chat_groups_path(@chat.chat_group.recruitment_id)
      # params[:recruitment][:recruitment_id]
  end
end

private
def chat_params
  params.require(:chat).permit(:chat, :chat_group_id)
end