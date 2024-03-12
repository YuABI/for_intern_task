module SupportTextDecorator
  extend ActiveSupport::Concern

  def text_sub_html(sym)
    escape_html(self[sym].to_s).gsub("\n", '<br/>').html_safe
  end

  def short_text_sub_html(sym, _limit = 20)
    escape_html(self[sym].to_s).truncate(_limit).gsub("\n", '<br/>').html_safe
  end

  def json_text_sub_html(sym)
    JSON.pretty_generate(JSON.parse(self[sym].to_s)).gsub("\n", '<br/>').html_safe
  rescue StandardError
    self[sym]
  end

  def text_sub_link(sym)
    _text = text_sub_html(sym)
    require 'uri'
    URI.extract(_text, %w[http https]).uniq.each do |url|
      sub_text = "<a href=#{url} target='_blank'>#{url}</a>"
      _text.gsub!(url, sub_text)
    end
    _text.html_safe
  end

  def sub_url_prev(sym, mode = :text)
    _text = mode == :text ? text_sub_html(sym) : self[sym].to_s
    require 'uri'
    URI.extract(_text, %w[http https]).uniq.each do |url|
      _text.gsub!(url, "#{url}#{url.include?('?') ? '&' : '?'}prev=1")
    end
    mode == :text ? _text.html_safe : _text
  end
end
