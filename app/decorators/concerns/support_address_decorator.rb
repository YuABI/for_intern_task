module SupportAddressDecorator
  extend ActiveSupport::Concern
  def join_name
    escape_html("#{user.family_name} #{user.first_name}").html_safe
  end

  def join_name_kana
    escape_html("#{user.family_name_kana} #{first_name_kana}").html_safe
  end

  def join_name_with_kana
    "#{join_name}(#{join_name_with_kana})"
  end

  def join_address
    "#{pref}#{city}#{address1} #{address2}"
  end

  def join_address_with_zip(sep1 = ' ', _sep2 = ' ')
    "〒#{zip}#{sep1}#{escape_html(join_address)}".html_safe
  end

  def join_address_with_zip_and_name(sep1 = ' ', _sep2 = ' ')
    "#{join_name} 〒#{zip}#{sep1}#{escape_html(join_address)}".html_safe
  end

  class_methods do
    def required_codes
      %i[
        family_name
        first_name
        family_name_kana
        first_name_kana
        zip
        pref
        city
        address1
        tel
      ]
    end
  end
end
