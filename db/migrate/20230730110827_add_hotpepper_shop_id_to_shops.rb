class AddHotpepperShopIdToShops < ActiveRecord::Migration[6.1]
  def change
    add_column :shops, :hotpepper_shop_id, :string
  end
end
