class Shop < ApplicationRecord
  has_many :users, dependent: :destroy
end
