class Public::RecruitmentsController < ApplicationController

  def new
    @recruitment=Recruitment.new
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
    @recruitments=Recruitment.all
  end

  def show
    @applications=Application.where(recruitment_id: params[:id])
    @application=Application.find_by(applicant_id: current_user.id)
    @recruitment=Recruitment.find(params[:id])
    @chat_group_user=ChatGroupUser.new
    chat_group=ChatGroup.where(recruitment_id: params[:id])
    @chat_group_users=ChatGroupUser.where(chat_group_id: chat_group.ids)
    if DateTime.now.after? @recruitment.deadline
      # @recruitment.is_valid.update(is_valid: false)
      @recruitment.is_valid==false
    end
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

  def destroy
    @applications=Application.where(recruitment_id: params[:id])
    @recruitment=Recruitment.find(params[:id])
    @chat_group_user=ChatGroupUser.new
    chat_group=ChatGroup.where(recruitment_id: params[:id])
    @chat_group_users=ChatGroupUser.where(chat_group_id: chat_group.ids)
    
    if @recruitment.destroy
      redirect_to history_recruitments_path
    else
      render :show
    end
  end

  def confirm
    @chat_group = ChatGroup.new(recruitment_id: params[:id])
    params[:chat_group_user][:user_ids].each do |user_id|
      @chat_group.chat_group_users << ChatGroupUser.new(user_id: user_id)
    end
  end

  def generate
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
    redirect_to  complete_recruitments_path
  end

  def history
    @recruitments=current_user.recruitments
    @recruitments_page = Recruitment.all.page(params[:page]).per(5)
  end
  
  def complete
  end
  
  def search
    # @search_params = recruitment_search_params  #検索結果の画面で、フォームに検索した値を表示するために、paramsの値をビューで使えるようにする
    # @recruitments = Recruitment.search(@search_params) #Reservationモデルのsearchを呼び出し、引数としてparamsを渡している。
    
    @recruitments = Recruitment.search(params[:keyword])
    @keyword = params[:keyword]
    # @recruitments_search = Recruitment.order(created_at: :desc);
    
    # @users_recruitments = Recruitment.where(prefectures: recruitment_params[:prefectures]) if recruitment_params[:prefectures].present?
    # @users_schedule = recruitments.where(age: user_params[:age]) if user_params[:age].present?
    # @users_title_introduction = Recruitment.where(["title like? OR introduction like?", "%#{keyword}%", "%#{keyword}%"]) if @keyword.present?
    
    # render json:{ status: 200, users: users }
    render "index"
  end

  private

  def recruitment_params
    params.require(:recruitment).permit(:title, :introduction, :schedule_one, :schedule_two, :schedule_three, :prefectures, :number_of_people, :recruitment_gender, :deadline)
  end
  
  # def recruitment_search_params
  #   params.fetch(:recruitment, {}).permit(:keyword, :check_in_from, :check_in_to, :prefectures)
  #   #fetch(:search, {})と記述することで、検索フォームに値がない場合はnilを返し、エラーが起こらなくなる
  #   #ここでの:searchには、フォームから送られてくるparamsの値が入っている
  # end

  # def chat_group_user_params
  #   params.permit(:user_id)
  #         # params.require(:chat_group_users).permit(:user_id, keys: [:applicant_id[]])
  # end
end
