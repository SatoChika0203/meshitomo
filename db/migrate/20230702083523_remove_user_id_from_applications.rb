class RemoveUserIdFromApplications < ActiveRecord::Migration[6.1]
  def change
    remove_column :applications, :user_id, :integer
  end
end
