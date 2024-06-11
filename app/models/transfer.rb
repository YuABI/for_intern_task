# == Schema Information
#
# Table name: transfers
#
#  id                                      :bigint           not null, primary key
#  available(利用区分)                     :integer          default(1), not null
#  bank_branch_code(支店コード)            :string           default(""), not null
#  bank_branch_name(支店)                  :string           default(""), not null
#  bank_code(金融機関番号)                 :string           default(""), not null
#  bank_name(金融機関名)                   :string           default(""), not null
#  bank_type(預金種別（普通、当座、貯蓄）) :integer          default(0), not null
#  bank_user_code(口座番号)                :string           default(""), not null
#  bank_user_name(口座名義)                :string           default(""), not null
#  deleted(削除区分)                       :integer          default(0), not null
#  deleted_at(削除日時)                    :datetime
#  name(名称)                              :string           default(""), not null
#  created_at                              :datetime         not null
#  updated_at                              :datetime         not null
#  organization_id(組織)                   :bigint           default(0), not null
#
class Transfer < ApplicationRecord

  belongs_to :organization

  validates :organization_id, :name, :bank_name, :bank_code, :bank_branch_name, :bank_branch_code,
            :bank_type, :bank_user_name, :bank_user_code, presence: true
end
