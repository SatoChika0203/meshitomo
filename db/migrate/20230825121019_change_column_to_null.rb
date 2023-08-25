class ChangeColumnToNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :recruitments, :deadline, true
  end
end
