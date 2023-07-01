class CreatePublicApplications < ActiveRecord::Migration[6.1]
  def change
    create_table :public_applications do |t|
      t.integer :recruitment_id, null: false
      t.integer :user_id, null: false
      t.date :schedule_one, null: false
      t.date :schedule_two
      t.date :schedule_three
      t.string :message
      t.boolean :is_approval, null: false, default: false
      t.timestamps
    end
  end
end
