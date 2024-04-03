class UserLifeplan < ApplicationRecord
  # TODO: まだUserができていないので、一旦コメントアウト
  # belongs_to :user
  has_many :user_lifeplan_beneficiaries, dependent: :destroy
  has_many :user_lifeplan_contacts, dependent: :destroy
  has_many :user_lifeplan_finance_conditions, dependent: :destroy
  has_many :user_lifeplan_incomes, dependent: :destroy
  has_many :user_lifeplan_expenses, dependent: :destroy
  has_many :user_lifeplan_assets, dependent: :destroy
end
