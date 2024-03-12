# == Schema Information
#
# Table name: admin_users
#
#  id                                  :bigint           not null, primary key
#  available(有効ならtrue)             :boolean          default(TRUE), not null
#  deleted(削除区分)                   :integer          default(0), not null
#  deleted_at(削除日時)                :datetime
#  email(メールアドレス)               :string           default(""), not null
#  hashed_password(ハッシュパスワード) :string           default(""), not null
#  last_logined_at(最終ログイン日時)   :datetime
#  name(氏名)                          :string           default(""), not null
#  salt                                :string
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#
# Indexes
#
#  index_admin_users_on_deleted            (deleted)
#  index_admin_users_on_email              (email)
#  index_admin_users_on_email_and_deleted  (email,deleted)
#
class AdminUser < ApplicationRecord
  include BaseAuthenticatable
  include EmailSetting

  def find_operation(operation_code)
    Operation.find_by(code: operation_code)
  end

  def target_operations(operation_category_id = nil)
    operations = Operation.all
    operations = operations.where(operation_category_id:) if operation_category_id
    operations
  end
  class << self
  end
end
