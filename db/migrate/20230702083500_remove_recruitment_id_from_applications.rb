class RemoveRecruitmentIdFromApplications < ActiveRecord::Migration[6.1]
  def change
    remove_column :applications, :recruitment_id, :integer
  end
end
