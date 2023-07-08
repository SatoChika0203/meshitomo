class ChangeIsValidDefaultOnRecruitments < ActiveRecord::Migration[6.1]
  def change
    change_column_default :recruitments, :is_valid, from: false, to: true
  end
end
