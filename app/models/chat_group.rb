class ChatGroup < ApplicationRecord
   has_many :chat_group_users, dependent: :destroy
   has_many :chats, dependent: :destroy
   belongs_to :recruitment

# def profile_image
#  unless user.image.attached?
#    file_path = Rails.root.join('app/assets/images/no_image.jpeg')
#    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
#  end
#  user.image
# end
end
