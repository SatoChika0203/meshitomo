class RenameShopIdColumnToShops < ActiveRecord::Migration[6.1]
  def change
    rename_column :shops, :shop_id, :recruitment_id
  end
end
