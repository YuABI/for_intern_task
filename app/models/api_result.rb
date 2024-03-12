# == Schema Information
#
# Table name: api_results
#
#  id                                    :bigint           not null, primary key
#  deleted(削除区分)                     :integer          default(0), not null
#  deleted_at(削除日時)                  :datetime
#  end_point(エンドポイント)             :text             default(""), not null
#  request_at(リクエスト日時)            :datetime
#  request_body(リクエスト内容)          :text
#  request_method(リクエストメソッド)    :integer          default("get"), not null
#  response_body(レスポンス内容)         :text
#  response_status(レスポンスステータス) :string
#  created_at                            :datetime         not null
#  updated_at                            :datetime         not null
#  api_client_id                         :bigint           not null
#  api_status_id(apiステータス)          :integer          default(1), not null
#
# Indexes
#
#  index_api_results_on_api_client_id              (api_client_id)
#  index_api_results_on_api_client_id_and_deleted  (api_client_id,deleted)
#  index_api_results_on_api_status_id              (api_status_id)
#  index_api_results_on_deleted                    (deleted)
#
class ApiResult < ApplicationRecord
  include RequestMethodSetting

  belongs_to :api_client
  belongs_to_active_model :api_status

  after_initialize :after_initialize_setup

  def after_initialize_setup
    nil unless new_record?
  end
  class << self
    def permit_params
      super + []
    end
  end
end
