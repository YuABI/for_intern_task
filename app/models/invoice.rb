# == Schema Information
#
# Table name: invoices
#
#  id                                     :bigint           not null, primary key
#  deleted(削除区分)                      :integer          default(0), not null
#  deleted_at(削除日時)                   :datetime
#  invoice_code(請求書番号)               :string           default(""), not null
#  payment_term_to_user(顧客宛支払い条件) :text             default(""), not null
#  regstered_at(請求ステータス)           :datetime
#  tax_rate(税率)                         :integer          default(0), not null
#  title(件名)                            :text             default(""), not null
#  total_price(請求金額)                  :integer          default(0), not null
#  created_at                             :datetime         not null
#  updated_at                             :datetime         not null
#  invoice_status_id(請求ステータス)      :integer          default(0), not null
#  member_id(作成した会員)                :bigint           default(0), not null
#  organization_id(組織)                  :bigint           default(0), not null
#  transfer_id(振込先)                    :bigint           default(0), not null
#  user_id(顧客)                          :bigint           default(0), not null
#
# Indexes
#
#  index_invoices_on_deleted              (deleted)
#  index_invoices_on_invoice_code         (invoice_code)
#  index_invoices_on_user_id              (user_id)
#  index_invoices_on_user_id_and_deleted  (user_id,deleted)
#
class Invoice < ApplicationRecord

  belongs_to :user
  belongs_to :member
  belongs_to :organization
  belongs_to :transfer
  has_many :invoice_details

  validates :user_id, :member_id, :organization_id, :title, :transfer_id, presence: true
end
