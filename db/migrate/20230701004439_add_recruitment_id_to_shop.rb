class AddRecruitmentIdToShop < ActiveRecord::Migration[6.1]
  def change
    add_column :shops, :shop_id, :integer
  end
end
