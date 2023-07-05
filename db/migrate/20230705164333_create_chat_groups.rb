class CreateChatGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :chat_groups do |t|
      t.integer :recruitment_id, null: false
      t.integer :is_valid, null: false, default: false
      t.timestamps
    end
  end
end
