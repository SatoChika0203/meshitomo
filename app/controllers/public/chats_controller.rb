class Public::ChatsController < ApplicationController
  def create
    @chat=current_user.chats.new(chat_params)
    @chat.save
    # byebug
    redirect_to recruitment_chat_groups_path(@chat.chat_group.recruitment_id)
    # params[:recruitment][:recruitment_id]
  end
end

private
def chat_params
  params.require(:chat).permit(:chat, :chat_group_id)
end