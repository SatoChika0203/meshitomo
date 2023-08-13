class ChangeColumnDefaultToShops < ActiveRecord::Migration[6.1]
  def change
    change_column_default :shops, :catch, from: nil, to: "-"
    change_column_default :shops, :open, from: nil, to: "-"
    change_column_default :shops, :close, from: nil, to: "-"
    change_column_default :shops, :genre, from: nil, to: "-"
    change_column_default :shops, :budget_average, from: nil, to: "-"
    change_column_default :shops, :access, from: nil, to: "-"
    change_column_default :shops, :parking, from: nil, to: "-"
    change_column_default :shops, :name, from: nil, to: "-"
    change_column_default :shops, :url, from: nil, to: "-"
    change_column_default :shops, :address, from: nil, to: "-"
    change_column_default :users, :prefecture, from: nil, to: "-"
    change_column_null :applications, :schedule_one, true
  end
end
