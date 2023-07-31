class UniqueColumnToShops < ActiveRecord::Migration[6.1]
  def change
    add_index :shops, :hotpepper_shop_id, unique: true
  end
end
