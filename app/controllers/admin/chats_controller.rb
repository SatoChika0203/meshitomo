class Admin::ChatsController < ApplicationController
  def destroy
    chat=Chat.find(params[:id])
    chat.destroy
    redirect_to admin_recruitment_chat_groups_path(chat.chat_group.recruitment.id)
  end
end
