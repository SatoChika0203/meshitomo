class Recruitment < ApplicationRecord
  # before_destroy :validate_is_valid_false

  belongs_to :user
  belongs_to :shop
  has_many :chat_groups
  has_many :applications, dependent: :destroy
  has_many :applicants, through: :applications, dependent: :destroy
  # applicationsの中にapplicants（応募者・Userに付随する）があるが、あくまで別物？

  validates :title, presence: true
  validates :introduction, presence: true
  validates :prefecture, presence: true
  validates :number_of_people, presence: true
  validates :recruitment_gender, presence: true
  validates :deadline, presence: true
  validates :shop_id, presence: true

  enum recruitment_gender: { male_only: 0, female_only: 1, anyone: 2 }
  enum number_of_people: { one_to_two: 0, three_to_five: 1, five_to_ten: 2, more_than_ten: 3 }
  enum prefecture:{
     北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
     茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
     新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
     岐阜県:21,静岡県:22,愛知県:23,三重県:24,
     滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
     鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
     徳島県:36,香川県:37,愛媛県:38,高知県:39,
     福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,
     沖縄県:47
  }

  def self.search(keyword)
    where(["title like? OR introduction like?", "%#{keyword}%", "%#{keyword}%"])
  end

  # def self.search(keyword)
  #   if search != ""
  #     where(["title like? OR introduction like?", "%#{search}%", "%#{search}%"])
  #   else
  #     Recruitment.all
  #   end
  # end

  def self.search(keyword, prefecture, schedule)
    result = Recruitment.joins(:shop).all
    if keyword.present?
      result = result.where(["recruitments.title like? OR recruitments.introduction like? OR shops.name like?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
    end

    if prefecture.present?
      result = result.where(prefecture: prefecture)
    end

    if schedule.present?
      result = result.where(schedule: schedule)
    end

    return result
  end


#     scope :search, -> (search_params) do      #scopeでsearchメソッドを定義。(search_params)は引数
#     return if search_params.blank?      #検索フォームに値がなければ以下の手順は行わない

#     title_or_introduction_like(search_params[:keyword])
#       .prefectures(search_params[:prefectures])
#       .schedule_one(search_params[:schedule_one])
#     #下記で定義しているscopeメソッドの呼び出し。「.」で繋げている
#   end

#   scope :title_or_introduction_like, -> (keyword) { where(["title like? OR introduction like?", "%#{keyword}%", "%#{keyword}%"]) if title&&introduction.present? }  #scopeを定義。
#   scope :prefectures, -> (prefectures) { where("prefectures like?", "%#{prefectures}%")}
#   scope :schedule_one, -> (schedule_one) { where("schedule_one like?", "%#{schedule_one}%")}
# #scope :メソッド名 -> (引数) { SQL文 }
# #if 引数.present?をつけることで、検索フォームに値がない場合は実行されない


end

  # def self.search(keyword, prefectures, schedule_one)
  #   where(["title like? OR introduction like? OR prefectures like? OR schedule_one like?", "%#{keyword}%", "%#{keyword}%", "%#{prefectures}%", "%#{schedule_one}%"])
  # end

#   scope :search, -> (search_params) do      #scopeでsearchメソッドを定義。(search_params)は引数
#     return if search_params.blank?      #検索フォームに値がなければ以下の手順は行わない

#     keyword(search_params[:keyword])
#       .check_in_from(search_params[:check_in_from])
#       .check_in_to(search_params[:check_in_to])
#       .prefectures_like(search_params[:prefectures])   #下記で定義しているscopeメソッドの呼び出し。「.」で繋げている
#   end

#   scope :keyword, -> (keyword) { where(["title like? OR introduction like?", "%#{keyword}%", "%#{keyword}%"])if keyword.present? }  #scopeを定義。
#   scope :check_in_from, -> (from) { where('? <= check_in', from) if from.present? }
#   scope :check_in_to, -> (to) { where('check_in <= ?', to) if to.present? }
#   #日付の範囲検索をするため、fromとtoをつけている
#   scope :prefectures_like, -> (prefectures) { where('prefectures LIKE ?', "%#{prefectures}%") if prefectures.present? }
# #scope :メソッド名 -> (引数) { SQL文 }
# #if 引数.present?をつけることで、検索フォームに値がない場合は実行されない



  # def can_destroy?
  #   :is_valid == false
  # end

  # private

  # def validate_is_valid_false
  #   return if can_destroy?
  #   if :application.present?
  #   errors.add(:base, 'この募集は削除できません。')
  #   throw :abort
  #   end
  # end

