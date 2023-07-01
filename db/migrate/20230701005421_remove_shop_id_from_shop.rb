class RemoveShopIdFromShop < ActiveRecord::Migration[6.1]
  def change
    remove_column :shops, :shop_id：integer, :string
  end
end
