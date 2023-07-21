class UserShop < ApplicationRecord
  has_one_attached :image
  
  belongs_to :user
  belongs_to :shop
end
