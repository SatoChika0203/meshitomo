class AddShopIdToRecruitments < ActiveRecord::Migration[6.1]
  def change
    add_column :recruitments, :shop_id, :integer
  end
end
