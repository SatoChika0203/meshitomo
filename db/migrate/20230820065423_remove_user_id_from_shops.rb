class RemoveUserIdFromShops < ActiveRecord::Migration[6.1]
  def change
    remove_column :shops, :user_id
  end
end
