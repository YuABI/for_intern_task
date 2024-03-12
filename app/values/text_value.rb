class TextValue < ApplicationValueObject
  attribute :text_value, :string

  def to_s
    text_value
  end

  def human
    ERB::Util.html_escape(text_value.to_s).gsub("\n", '<br/>').html_safe
  end

  def short_human(_limit = 20)
    ERB::Util.html_escape(text_value.to_s).truncate(_limit).gsub("\n", '<br/>').html_safe
  end
end
