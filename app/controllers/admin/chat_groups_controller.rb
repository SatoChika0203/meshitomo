class Admin::ChatGroupsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @chat_groups=ChatGroup.all
    @chat_groups=ChatGroup.all.page(params[:page])
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
end