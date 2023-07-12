class Public::ChatsController < ApplicationController
  def create
    @chat=Chat.new(chat_params)
    @chat.save
    redirect_to recruitment_chat_groups_path(@recruitment.id)
  end
end

private
def chat_params
  params.require(:chat).permit(:chat)
end