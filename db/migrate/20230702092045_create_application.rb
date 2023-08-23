class CreateApplication < ActiveRecord::Migration[6.1]
  def change
    create_table :applications do |t|
      t.references :recruitment, foreign_key: true
      t.references :applicant, foreign_key: {to_table: :users} 
      t.date :schedule_one
      t.date :schedule_two
      t.date :schedule_three
      t.string :message
      t.boolean :is_approval, null: false, default: false
      t.boolean :is_valid, null: false, default: true
      t.timestamps
    end
  end
end
