class Public::ChatGroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:show]
  before_action :is_matching_recruitment_user, only: [:confirm, :destroy]

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
    flash[:notice]="お食事は楽しかったですか？また募集してくださいね！"
    redirect_to chat_groups_path
  end


private
  def is_matching_login_user
    chat_group=ChatGroup.find_by(recruitment_id: params[:recruitment_id])
    chat_group_users=ChatGroupUser.where(chat_group_id: chat_group.id)
    unless chat_group_users.pluck(:user_id).include?(current_user.id)
        redirect_to chat_groups_path
    end
    # unless chat_group_user.user.id == current_user.id
    #   redirect_to recruitments_path
    # end
  end

  def is_matching_recruitment_user
    recruitment=Recruitment.find(params[:recruitment_id])
    unless recruitment.user.id == current_user.id
      redirect_to recruitments_path
    end
  end
end