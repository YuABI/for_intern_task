class AddUserIdToUserLifeplans < ActiveRecord::Migration[7.1]
  def change
    add_reference :user_lifeplans, :user, null: false, foreign_key: true

    change_column :user_lifeplans, :background_reason, :string, default: '', null: false
    change_column :user_lifeplans, :legal_heir, :string, default: '', null: false
    change_column :user_lifeplans, :residue, :string, default: '', null: false
    change_column :user_lifeplans, :relatives, :string, default: '', null: false
    change_column :user_lifeplans, :household_disposal, :string, default: '', null: false
    change_column :user_lifeplans, :real_estate_disposal, :string, default: '', null: false
    change_column :user_lifeplans, :close_grave, :string, default: '', null: false
    change_column :user_lifeplans, :funeral_memorial_policy, :string, default: '', null: false

    add_column :user_lifeplan_incomes, :user_lifeplan_income_kind, :string, default: '', null: false
    change_column :user_lifeplan_incomes, :income_kind, :string, default: '', null: false
    change_column :user_lifeplan_incomes, :asset_income_kind, :string, default: '', null: false
    rename_column :user_lifeplan_incomes, :asset_income_kind, :pension_kind
    rename_column :user_lifeplan_incomes, :income_kind, :cache_income_kind
    remove_column :user_lifeplan_incomes, :assets_number, :integer, default: 0, null: false

    add_column :user_lifeplan_expenses, :user_lifeplan_expense_kind, :string, default: '', null: false
    change_column :user_lifeplan_expenses, :note, :string, default: '', null: false
    change_column :user_lifeplan_expenses, :expenditure_item_name, :string, default: '', null: false
    change_column :user_lifeplan_expenses, :content, :string, default: '', null: false
    remove_column :user_lifeplan_expenses, :assets_number, :integer, default: 0, null: false

    add_column :user_lifeplan_assets, :user_lifeplan_asset_kind, :string, default: '', null: false
    change_column :user_lifeplan_assets, :asset_kind, :string, default: '', null: false
    change_column :user_lifeplan_assets, :deposit_kind, :string, default: '', null: false
    rename_column :user_lifeplan_assets, :deposit_kind, :cache_deposit_kind
    rename_column :user_lifeplan_assets, :asset_kind, :other_assets_kind
    remove_column :user_lifeplan_assets, :asset_number, :integer, default: 0, null: false

    change_column :user_lifeplan_contacts, :contact_kind, :string, default: '', null: false
    rename_column :user_lifeplan_contacts, :contact_kind, :user_lifeplan_contact_kind
    add_column :user_lifeplan_contacts, :contact_level_kind, :string, default: '', null: false
  end
end
