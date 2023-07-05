class CreateChatGroupUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :chat_group_users do |t|
      t.integer :user_id, null: false
      t.integer :chat_group_id, null: false
      t.timestamps
    end
  end
end
