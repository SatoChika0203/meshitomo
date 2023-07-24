class AddColumnsToShops < ActiveRecord::Migration[6.1]
  def change
    add_column :shops, :catch, :string
    add_column :shops, :open, :string
    add_column :shops, :close, :string
    add_column :shops, :genre, :string
    add_column :shops, :budget_average, :string
    add_column :shops, :access, :string
    add_column :shops, :parking, :string
    rename_column :shops, :shop_name, :name
    rename_column :shops, :shop_url, :url
    rename_column :shops, :shop_address, :address
  end
end
