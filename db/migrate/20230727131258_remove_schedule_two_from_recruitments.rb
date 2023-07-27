class RemoveScheduleTwoFromRecruitments < ActiveRecord::Migration[6.1]
  def change
    remove_column :recruitments, :schedule_two, :date
    remove_column :recruitments, :schedule_three, :date
    change_column_null :recruitments, :schedule_one, :true, 0
    rename_column :recruitments, :prefectures, :prefecture
    rename_column :recruitments, :schedule_one, :schedule
  end
end
