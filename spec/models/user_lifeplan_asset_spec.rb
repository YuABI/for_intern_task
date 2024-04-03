# == Schema Information
#
# Table name: user_lifeplan_assets
#
#  id                         :bigint           not null, primary key
#  account_number             :string           default(""), not null
#  amount_of_money            :integer          default(0), not null
#  asset_appraisal_value      :integer          default(0), not null
#  asset_kind                 :integer          default(0), not null
#  asset_number               :integer          default(0), not null
#  company_name               :string           default(""), not null
#  content                    :string           default(""), not null
#  deleted                    :integer          default(0), not null
#  deleted_at                 :datetime
#  deposit_kind               :integer          default(0), not null
#  description                :string           default(""), not null
#  equity_appraisal_value     :integer          default(0), not null
#  financial_institution_name :string           default(""), not null
#  name                       :string           default(""), not null
#  profit                     :integer          default(0), not null
#  rate                       :integer          default(0), not null
#  reference_at               :datetime
#  scheduled_for_sale         :integer          default(0), not null
#  store_name                 :string           default(""), not null
#  sundry_expenses            :integer          default(0), not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  user_lifeplan_id           :bigint           not null
#
# Indexes
#
#  index_user_lifeplan_assets_on_user_lifeplan_id  (user_lifeplan_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_lifeplan_id => user_lifeplans.id)
#
require 'rails_helper'

RSpec.describe UserLifeplanAsset, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
