class CreateApplication < ActiveRecord::Migration[6.1]
  def change
    create_table :applications do |t|
      t.references :recruitment, foreign_key: true
      t.references :applicant, foreign_key: {to_table: :users} 
      t.date :schedule_one, null: false
      t.date :schedule_two
      t.date :schedule_three
      t.string :message
      t.boolean :is_approval, null: false, default: false
      t.timestamps
    end
  end
end
