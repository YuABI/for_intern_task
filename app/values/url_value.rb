class UrlValue < ApplicationValueObject
  attribute :url_value, :string

  # @note URL情報をそのまま返してくれる
  # @return [String]
  def to_s
    url_value
  end

  # @note URL情報をparseした内容で返してくれる
  # @return [URI::HTTPS]
  def parse_url
    URI.parse(url_value)
  end

  delegate :host, to: :parse_url

  delegate :path, to: :parse_url

  delegate :query, to: :parse_url

  # 引数で渡したクエリとURL情報を連結して返す
  # other_queryで渡した情報は、? 以降のオプション情報の文字列を指定する。
  # 指定がない場合は、url_valueの情報をそのまま返す

  # @note 引数で渡したクエリとURL情報を連結して返す
  # @param other_query [String] URLの引数情報
  # @return [String]
  def generate_url(other_query = nil)
    return to_s if other_query.blank?
    return "#{self}?#{other_query}" if query.blank?

    "#{self}&#{other_query}"
  end

  delegate :scheme, to: :parse_url

  delegate :port, to: :parse_url

  # @note セキュアなURL(https://~~~)の情報を返す
  # @return [String]
  def secure_url
    return to_s if Rails.env.development?

    to_s.gsub('http://', 'https://')
  end

  # @return [String]
  def only_url
    _url = "#{scheme}://#{host}"
    _url += ":#{port}" if host == 'localhost'
    _url
  end
end
