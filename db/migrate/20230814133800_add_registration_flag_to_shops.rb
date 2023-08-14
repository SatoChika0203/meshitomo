class AddRegistrationFlagToShops < ActiveRecord::Migration[6.1]
  def change
    add_column :shops, :registration_flg, :integer, null: false, default: 0, comment: '0が登録済み、1が登録解除済み'
  end
end
