class RenameColumnToShops < ActiveRecord::Migration[6.1]
  def change
    change_column_null :shops, :genre, :string, false
    change_column_null :shops, :open, :string, false
    change_column_null :shops, :close, :string, false
  end
end
