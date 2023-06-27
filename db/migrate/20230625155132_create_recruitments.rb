class CreateRecruitments < ActiveRecord::Migration[6.1]
  def change
    create_table :recruitments do |t|
      t.string :title, null: false
      t.string :introduction, null: false
      t.date :schedule_one, null: false
      t.date :schedule_two
      t.date :schedule_three
      t.integer :prefectures, null: false
      t.integer :number_of_people, null: false
      t.integer :recruitment_gender, null: false
      t.datetime :deadline, null: false
      t.boolean :is_valid, null: false, default: false
      t.timestamps
      
      
    end
  end
end
