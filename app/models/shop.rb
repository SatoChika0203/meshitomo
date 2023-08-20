class Shop < ApplicationRecord

  has_many :user_shops#, dependent: :destroy
  has_many :recruitments#, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :user, through: :favorites#, optional: true
  
  def user_shop_by?(user)
    user_shop.exists?(user_id: user.id)
  end
end
