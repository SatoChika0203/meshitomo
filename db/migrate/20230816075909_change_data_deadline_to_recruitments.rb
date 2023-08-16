class ChangeDataDeadlineToRecruitments < ActiveRecord::Migration[6.1]
  def change
    change_column :recruitments, :deadline, :date
  end
end
