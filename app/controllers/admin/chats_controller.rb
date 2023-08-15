class Admin::ChatsController < ApplicationController
  before_action :authenticate_admin!
  
  def destroy
    chat=Chat.find(params[:id])
    chat.destroy
    redirect_to admin_recruitment_chat_groups_path(chat.chat_group.recruitment.id)
  end
end
