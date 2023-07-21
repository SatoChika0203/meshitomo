class AddColumnsToUserShops < ActiveRecord::Migration[6.1]
  def change
    add_column :user_shops, :name, :string
    add_column :user_shops, :catch, :string
    add_column :user_shops, :address, :string
    add_column :user_shops, :open, :string
    add_column :user_shops, :close, :string
    add_column :user_shops, :urls, :string
  end
end
