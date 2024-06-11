class AddNursingCareStartYearToUserLifeplans < ActiveRecord::Migration[7.1]
  def change
    add_column :user_lifeplans, :start_pension_age, :integer, null: false, default: 0
    add_column :user_lifeplans, :start_resident_elderly_facility_age, :integer, null: false, default: 0
    add_column :user_lifeplans, :start_nursing_care_age, :integer, null: false, default: 0
    add_column :user_lifeplans, :death_age, :integer, null: false, default: 0
    rename_column :user_lifeplans, :status, :user_lifeplan_status_id
    change_column :user_lifeplans, :user_lifeplan_status_id, :integer, null: false, default: 1
    rename_column :user_lifeplans, :apply_reviewed_at, :review_requested_at
    add_column :user_lifeplans, :review_started_at, :integer
    rename_column :user_lifeplans, :reviewed_at, :review_completed_at
    add_reference :user_lifeplans, :admin_user, foreign_key: true
  end
end
