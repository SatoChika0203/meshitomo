class CreateShops < ActiveRecord::Migration[6.1]
  def change
    create_table :shops do |t|
      t.string :name, null: false, default: "-"
      t.string :url, null: false, default: "-"
      t.string :address, null: false, default: "-"
      t.integer :recruitment_id
      t.string :catch, default: "-"
      t.string :open, default: "-"
      t.string :close, default: "-"
      t.string :genre, default: "-"
      t.string :budget_average, default: "-"
      t.string :access, default: "-"
      t.string :parking, default: "-"
      t.string :img
      t.string :hotpepper_shop_id, unique: true
      t.timestamps
    end
  end
end
