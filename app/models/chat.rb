class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :chat_group
  
  validates :chat, presence: true, length: { in: 1..150 }
end
