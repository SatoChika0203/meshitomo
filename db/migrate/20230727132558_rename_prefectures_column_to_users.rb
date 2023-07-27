class RenamePrefecturesColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :prefectures, :prefecture
  end
end
