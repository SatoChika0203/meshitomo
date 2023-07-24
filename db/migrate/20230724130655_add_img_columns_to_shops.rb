class AddImgColumnsToShops < ActiveRecord::Migration[6.1]
  def change
    add_column :shops, :img, :string
  end
end
