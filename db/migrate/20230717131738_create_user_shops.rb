class CreateUserShops < ActiveRecord::Migration[6.1]
  def change
    create_table :user_shops do |t|
      t.integer "user_id", null: false
      t.integer "shop_id", null: false
      t.timestamps
    end
  end
end
