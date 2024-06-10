# == Schema Information
#
# Table name: product_option_mappings
#
#  id                              :bigint           not null, primary key
#  deleted(削除区分)               :integer          default(0), not null
#  deleted_at(削除日時)            :datetime
#  product_options(商材オプション) :bigint           default(0), not null
#  products(商材)                  :bigint           default(0), not null
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#
class ProductOptionMapping < ApplicationRecord

  belongs_to :product
  belongs_to :product_option

end
