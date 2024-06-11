# == Schema Information
#
# Table name: products
#
#  id                                :bigint           not null, primary key
#  available(利用区分)               :integer          default(1), not null
#  code(コード)                      :string           default(""), not null
#  deleted(削除区分)                 :integer          default(0), not null
#  deleted_at(削除日時)              :datetime
#  invoice_detail_name(請求書明細名) :string           default(""), not null
#  name(名称)                        :string           default(""), not null
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#
# Indexes
#
#  index_products_on_deleted  (deleted)
#
class Product < ApplicationRecord
  self.table_name = 'products'

  has_many :product_option_mappings
  has_many :product_options, through: :product_option_mappings

  validates :name, :code, :invoice_detail_name, presence: true
end
