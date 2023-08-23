class CreateRecruitments < ActiveRecord::Migration[6.1]
  def change
    create_table :recruitments do |t|
      t.string :title, null: false
      t.string :introduction, null: false
      t.date :schedule
      t.integer :prefecture, null: false
      t.integer :number_of_people, null: false
      t.integer :recruitment_gender, null: false
      t.date :deadline, null: false
      t.boolean :is_valid, null: false, default: true
      t.integer :user_id
      t.integer :shop_id
      t.timestamps
      
      
    end
  end
end
