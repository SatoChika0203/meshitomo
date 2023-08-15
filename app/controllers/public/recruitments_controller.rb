class Public::RecruitmentsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @recruitment=Recruitment.new
    @shops=Shop.where(user_id: current_user.id, registration_flg: 0)
  end

  def create
    @recruitment=Recruitment.new(recruitment_params)
    @recruitment.user_id=current_user.id
    if @recruitment.save
      redirect_to recruitment_path(@recruitment.id)
    else
      render :new
    end
  end

  def index
    @recruitments_male_only=Recruitment.where(recruitment_gender: 0).or(Recruitment.where(recruitment_gender: 2)).page(params[:page])
    @recruitments_female_only=Recruitment.where(recruitment_gender: 1).or(Recruitment.where(recruitment_gender: 2)).page(params[:page])
    # @recruitments_female_only=Recruitment.where.not(recruitment_gender: 0)
    @recruitments_anyone=Recruitment.where(recruitment_gender: 2).page(params[:page])

    @recruitments_male_only=Recruitment.where(recruitment_gender: 0).or(Recruitment.where(recruitment_gender: 2)).order(created_at: :desc).page(params[:page])
    @recruitments_female_only=Recruitment.where(recruitment_gender: 1).or(Recruitment.where(recruitment_gender: 2)).order(created_at: :desc).page(params[:page])
    @recruitments_anyone=Recruitment.where(recruitment_gender: 2).order(created_at: :desc).page(params[:page])    
  end

  def show
    @applications=Application.where(recruitment_id: params[:id])
    # @application=Application.find_by(applicant_id: current_user.id)
    @recruitment=Recruitment.find(params[:id])
    @chat_group_user=ChatGroupUser.new
    chat_group=ChatGroup.where(recruitment_id: params[:id])
    @chat_group_users=ChatGroupUser.where(chat_group_id: chat_group.ids)
    if DateTime.now.after? @recruitment.deadline
      # @recruitment.is_valid.update(is_valid: false)
      @recruitment.update(is_valid: false)
    end

    # @shop=Shop.find_by(id: params[:shop_id])
    # :shop_id　はshowに渡されていないため使用できない
  end

  def edit
    @recruitment=Recruitment.find(params[:id])
  end

  def update
    @recruitment=Recruitment.find(params[:id])
    if @recruitment.update(recruitment_params)
      redirect_to recruitment_path(@recruitment.id)
    else
      render :edit
    end
  end
  
  def withdraw
    recruitment=Recruitment.find(params[:id])
    recruitment.update(is_valid: false)
    # is_deletedカラムをtrueにupdateする事により、退会状態を作り出す
    redirect_to user_path(current_user.id)
  end

  # def destroy
  #   @applications=Application.where(recruitment_id: params[:id])
  #   @recruitment=Recruitment.find(params[:id])
  #   @chat_group_user=ChatGroupUser.new
  #   chat_group=ChatGroup.where(recruitment_id: params[:id])
  #   @chat_group_users=ChatGroupUser.where(chat_group_id: chat_group.ids)

  #   if @recruitment.destroy
  #     redirect_to history_recruitments_path
  #   else
  #     render :show
  #   end
  # end

  def confirm
    @chat_group = ChatGroup.new(recruitment_id: params[:id])
    params[:chat_group_user][:user_ids].each do |user_id|
      @chat_group.chat_group_users << ChatGroupUser.new(user_id: user_id)
    end
  end

  def generate
    recruitment=Recruitment.find(params[:id])
    user_ids = params[:chat_group][:user_ids].split(',').map(&:to_i)
    user_ids.unshift(current_user.id) #配列の先頭に要素を追加
    ActiveRecord::Base.transaction do  #中の記述をひとまとめに実行する。何か1つでも実行されなかったら終了
      Recruitment.find(params[:id]).update(is_valid: false)
      # Application.where(recruitment_id: params[:id]).update_all(is_valid: false)
      Application.where(recruitment_id: params[:id], applicant_id: user_ids).update_all(is_approval: true)
      @chat_group = ChatGroup.new(recruitment_id: params[:id])
      @chat_group.chat_group_users = user_ids.map do |user_id| ChatGroupUser.new(user_id: user_id) end
      @chat_group.save
    end
    redirect_to  complete_recruitment_path(recruitment.id)
  end
  
  def complete
    @recruitment=Recruitment.find(params[:id])
  end

  def history
    @recruitments=current_user.recruitments.page(params[:page])
    # @recruitments_page = Recruitment.all.page(params[:page]).per(5)
    @recruitments=current_user.recruitments.order(created_at: :desc).page(params[:page])
  end

  def search
    @keyword = params[:keyword]
    @prefecture = params[:prefecture]
    @schedule = params[:schedule]

    male_only = Recruitment.where(recruitment_gender: 0).or(Recruitment.where(recruitment_gender: 2))
    female_only = Recruitment.where(recruitment_gender: 1).or(Recruitment.where(recruitment_gender: 2))
    anyone = Recruitment.where(recruitment_gender: 2)

    if current_user.gender == "male"
      @recruitments_male_only = male_only.search(
        params[:keyword],
        params[:prefecture],
        params[:schedule]
      ).page(params[:page])
    elsif current_user.gender == "female"
      @recruitments_female_only = female_only.search(
        params[:keyword],
        params[:prefecture],
        params[:schedule]
      ).page(params[:page])
    else
      @recruitments_anyone = anyone.search(
        params[:keyword],
        params[:prefecture],
        params[:schedule]
      ).page(params[:page])
    end

    render "index"
=begin
    # if current_user.gender == "male"
    #   @recruitments_male_only = male_only.search(params[:keyword])
    # elsif current_user.gender == "female"
    #   @recruitments_female_only = female_only.search(params[:keyword])
    # else current_user.gender == "male" && "female" && "other"
    #   @recruitments_anyone = anyone.search(params[:keyword])
    # end
    # render "index"


    # @search_params = recruitment_search_params  #検索結果の画面で、フォームに検索した値を表示するために、paramsの値をビューで使えるようにする
    # if current_user.gender == "male"
    #   @recruitments_male_only = male_only.search(@search_params).joins(:user)
    # elsif current_user.gender == "female"
    #   @recruitments_female_only = female_only.search(@search_params).joins(:user)
    # else current_user.gender == "male" && "female" && "other"
    #   @recruitments_anyone = anyone.search(@search_params).joins(:user)
    # end
    # render "index"
=end
  end

  private

  def recruitment_params
    params.require(:recruitment).permit(:title, :introduction, :schedule, :prefecture, :number_of_people, :recruitment_gender, :deadline, :shop_id)
  end



  # def recruitment_search_params
  #   params.fetch(:recruitment, {}).permit(:keyword, :prefectures, :schedule_one)
  #   #fetch(:search, {})と記述することで、検索フォームに値がない場合はnilを返し、エラーが起こらなくなる
  #   #ここでの:searchには、フォームから送られてくるparamsの値が入っている
  # end

  # def chat_group_user_params
  #   params.permit(:user_id)
  #         # params.require(:chat_group_users).permit(:user_id, keys: [:applicant_id[]])
  # end
end
