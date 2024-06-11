# == Schema Information
#
# Table name: product_options
#
#  id                                           :bigint           not null, primary key
#  available(利用区分)                          :integer          default(1), not null
#  code(コード)                                 :string           default(""), not null
#  cycle_schedule(サイクル時の期間数（○ヶ月）) :integer          default(0), not null
#  cycle_type(サイクルタイプ（単発or定期）)     :integer          default(0), not null
#  deleted(削除区分)                            :integer          default(0), not null
#  deleted_at(削除日時)                         :datetime
#  name(名称)                                   :string           default(""), not null
#  price(料金)                                  :integer          default(0), not null
#  created_at                                   :datetime         not null
#  updated_at                                   :datetime         not null
#  product_category_id(商材カテゴリー)          :bigint           default(0), not null
#
# Indexes
#
#  index_product_options_on_deleted                          (deleted)
#  index_product_options_on_product_category_id              (product_category_id)
#  index_product_options_on_product_category_id_and_deleted  (product_category_id,deleted)
#
class ProductOption < ApplicationRecord

  belongs_to :product_category
  has_many :product_option_mappings
  has_many :products, through: :product_option_mappings

  validates :name, :code, :price, presence: true
end
