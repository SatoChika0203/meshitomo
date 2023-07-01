class AddUserIdToRecruitments < ActiveRecord::Migration[6.1]
  def change
    add_column :recruitments, :user_id, :integer
  end
end
