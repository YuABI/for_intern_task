# == Schema Information
#
# Table name: product_option_mappings
#
#  id                                :bigint           not null, primary key
#  deleted(削除区分)                 :integer          default(0), not null
#  deleted_at(削除日時)              :datetime
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#  product_id(商材)                  :bigint           default(0), not null
#  product_option_id(商材オプション) :bigint           default(0), not null
#
class ProductOptionMapping < ApplicationRecord

  belongs_to :product
  belongs_to :product_option

end
