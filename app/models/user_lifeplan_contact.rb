# == Schema Information
#
# Table name: user_lifeplan_contacts
#
#  id                         :bigint           not null, primary key
#  contact_level_kind         :string           default(NULL), not null
#  deleted                    :integer          default(0), not null
#  deleted_at                 :datetime
#  name                       :string           default(""), not null
#  user_lifeplan_contact_kind :string           default(NULL), not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  user_lifeplan_id           :bigint           not null
#
# Indexes
#
#  index_user_lifeplan_contacts_on_user_lifeplan_id  (user_lifeplan_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_lifeplan_id => user_lifeplans.id)
#
class UserLifeplanContact < ApplicationRecord
  belongs_to :user_lifeplan
  has_many_attached :docs

  enumerize :user_lifeplan_contact_kind, in: %i[
    testament power_of_attorney guardianship_agreement post_mortem_proxy deposit_management_contract declaration_of_intent
  ]

  enumerize :contact_level_kind, in: %i[
    unselected standard irregular
  ]

  class << self
    def permit_params
      %i[user_lifeplan_id name user_lifeplan_contact_kind contact_level_kind]
    end
  end
end
