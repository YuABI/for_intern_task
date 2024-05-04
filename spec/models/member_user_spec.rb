# == Schema Information
#
# Table name: member_users
#
#  id                          :bigint           not null, primary key
#  deleted(削除区分)           :integer          default(0), not null
#  deleted_at(削除日時)        :datetime
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  member_id(会員・パートナー) :bigint           default(0), not null
#  user_id(顧客)               :bigint           default(0), not null
#
# Indexes
#
#  index_member_users_on_deleted              (deleted)
#  index_member_users_on_user_id_and_deleted  (user_id,deleted)
#
require 'rails_helper'

RSpec.describe MemberUser, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
