class ChatGroup < ApplicationRecord
   has_many :chat_group_users, dependent: :destroy
   has_many :chats, dependent: :destroy
   belongs_to :recruitment
end
