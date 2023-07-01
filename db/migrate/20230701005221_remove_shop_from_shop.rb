class RemoveShopFromShop < ActiveRecord::Migration[6.1]
  def change
    remove_column :shops, :shop：integer, :string
  end
end
