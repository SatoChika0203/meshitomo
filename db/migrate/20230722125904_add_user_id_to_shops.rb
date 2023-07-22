class AddUserIdToShops < ActiveRecord::Migration[6.1]
  def change
    add_column :shops, :user_id, :integer
    change_column :shops, :user_id, :integer, null: false
  end
end
