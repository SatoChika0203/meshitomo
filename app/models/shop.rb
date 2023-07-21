class Shop < ApplicationRecord
  has_one_attached :image
    
  has_many :user_shops, dependent: :destroy
  has_many :recruitments, dependent: :destroy
  
  def user_shop_by?(user)
    user_shop.exists?(user_id: user.id)
  end
end
