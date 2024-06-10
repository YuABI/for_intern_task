# == Schema Information
#
# Table name: invoice_details
#
#  id                          :bigint           not null, primary key
#  content(明細名)             :text             default(""), not null
#  deleted(削除区分)           :integer          default(0), not null
#  deleted_at(削除日時)        :datetime
#  mode(区分)                  :integer          default(0), not null
#  price(単価)                 :integer          default(0), not null
#  qty(数量)                   :integer          default(1), not null
#  tax_rate(税率)              :integer          default(0), not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  invoice_id(請求書)          :bigint           default(0), not null
#  product_detail_id(商材明細) :bigint           default(0), not null
#
# Indexes
#
#  index_invoice_details_on_deleted                        (deleted)
#  index_invoice_details_on_invoice_id                     (invoice_id)
#  index_invoice_details_on_invoice_id_and_deleted         (invoice_id,deleted)
#  index_invoice_details_on_product_detail_id              (product_detail_id)
#  index_invoice_details_on_product_detail_id_and_deleted  (product_detail_id,deleted)
#
class InvoiceDetail < ApplicationRecord

  belongs_to :invoice
  belongs_to :product_detail

  validates :price, :qty, :tax_rate, :content, presence: true
end
