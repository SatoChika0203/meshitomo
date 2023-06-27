class CreateShops < ActiveRecord::Migration[6.1]
  def change
    create_table :shops do |t|
      t.string :shop_name, null: false
      t.string :shop_url, null: false
      t.string :shop_address, null: false
      t.timestamps
    end
  end
end
