class RenameUserIdColumnToRecruitments < ActiveRecord::Migration[6.1]
  def change
    rename_column :recruitments, :user_id, :user_id
  end
end
