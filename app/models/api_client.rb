# == Schema Information
#
# Table name: api_clients
#
#  id                                                  :bigint           not null, primary key
#  api_access_token(アクセストークン)                  :string           default(""), not null
#  api_access_token_expired_at(アクセストーク有効期限) :datetime
#  api_key(APIキー)                                    :string           default(""), not null
#  api_secret_key(シークレットキー)                    :string           default(""), not null
#  deleted(削除区分)                                   :integer          default(0), not null
#  deleted_at(削除日時)                                :datetime
#  name(名称)                                          :string           default(""), not null
#  created_at                                          :datetime         not null
#  updated_at                                          :datetime         not null
#
# Indexes
#
#  index_api_clients_on_api_access_token              (api_access_token)
#  index_api_clients_on_api_access_token_and_deleted  (api_access_token,deleted)
#  index_api_clients_on_deleted                       (deleted)
#
class ApiClient < ApplicationRecord
  has_many :api_results

  validates :name, presence: {}
  before_create :generate_api_key

  def generate_api_key
    generate_random(:api_key)
    generate_random(:api_secret_key)
  end

  def generate_access_token
    generate_random(:api_access_token)
    self.api_access_token_expired_at = system_datetime.since(120.minutes)
    self.skip_validate_save
  end

  def unexpired?
    api_access_token_expired_at > system_datetime
  end

  def generate_random(token_code)
    loop do
      self[token_code] = SecureRandom.hex(32)
      break unless self.class.find_by(token_code => self[token_code])
    end
  end

  def create_results(**args)
    request   = args[:request]
    response  = args[:response]

    api_result = self.api_results.build(
      api_status_id: ApiStatus.send(response.successful? ? :success : :failure).id,
      end_point: request.path,
      request_method: request.method_symbol,
      request_body: request.request_parameters.to_json.to_s,
      response_status: response.status,
      response_body: response.body.to_s,
      request_at: system_datetime
    )
    if api_result.use_query? && request.request_parameters.blank?
      api_result.request_body = request.query_parameters.to_json.to_s
    end

    api_result.standard_save!
  end
  class << self
  end
end
