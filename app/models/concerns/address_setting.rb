module AddressSetting
  extend ActiveSupport::Concern
  included do
    before_validation :convert_attribute
    # before_save :tel_split
    validates :zip, :pref, :city, :address1, presence: {}
    validates :zip, presence: {}, format: Regex::ZIP

    validates :tel, presence: {}, format: Regex::TEL
    validate :valid_zip?
    validate :valid_tel?

    def valid_zip?
      set_target_config
      return false if zip.blank?

      # zip_list = ZipList.find_address(zip)
      # unless zip_list && pref == zip_list&.pref
      #   self.errors.add(:zip, "は都道府県が一致しません。")
      # end
      true
    end

    def valid_tel?
      set_target_config
      tel_codes = ['tel']
      tel_lengths   = target_config.tel_lengths
      mobile_heads  = target_config.mobile_heads
      mobile_length = target_config.mobile_length
      tel_codes.each do |tel_code|
        check_tel = self.send(tel_code)
        _tel_name = ''
        unless tel_lengths.include?(check_tel.length)
          self.errors.add("#{tel_code}".to_sym, "#{_tel_name}は市外局番が抜けている場合はご記入下さい。")
        end
        if mobile_heads.include?(check_tel.to_s.slice(0, 3))
          self.errors.add("#{tel_code}".to_sym, "#{_tel_name}の入力内容が正しくありません。") if check_tel.length != mobile_length
        elsif check_tel.length == mobile_length
          unless mobile_heads.include?(check_tel.to_s.slice(
                                         0, 3
                                       ))
            self.errors.add("#{tel_code}".to_sym,
                            "#{_tel_name}の入力内容が正しくありません。")
          end
        end
      end
    end
  end

  def mode_sample?
    self.is_a?(SampleUser)
  end

  def pref_other?
    PrefList.other_record.value == pref
  end

  # 不要な文字や全角除去
  def convert_attribute
    # 全角を半角へ変換
    %i[
      zip tel email email_confirmation
    ].each do |sym|
      self[sym] = self[sym].to_s.to_hankaku if has_attribute?(sym)
    end
    # 半角を全角へ変換
    %i[
      first_name family_name
    ].each do |sym|
      self[sym] = self[sym].to_s.to_zenkaku if has_attribute?(sym)
    end
    # カナへ変換
    %i[
      first_name_kana family_name_kana
    ].each do |sym|
      self[sym] = self[sym].to_s.to_katakana_zenkaku if has_attribute?(sym)
    end
    # 数字以外除去
    %i[
      zip tel
    ].each do |sym|
      self[sym] = self[sym].to_s.delete('^0-9') if has_attribute?(sym)
    end
    # 半角スペースを全角へ変換
    %i[
      first_name family_name first_name_kana family_name_kana
    ].each do |sym|
      self[sym] = self[sym].to_s.gsub(' ', '　') if has_attribute?(sym)
    end
    self
  end

  # _addressのデータをコピー
  def copy_address(_address)
    self.class.address_columns.each do |sym|
      self[sym] = begin
        _address[sym]
      rescue StandardError
        ''
      end
    end
    self
  end

  def all_address_combine(format = nil)
    _address = %i[
      family_name
      first_name
      zip
      pref
      city
      address
      building
      tel
    ].map { |i| self.send(i).to_s.strip }.join('')
    _address = _address.to_s.replace_address_format if format == :replace
    _address
  end

  def address_same?
    user.user_shipping_address.all_address_combine(:replace) == all_address_combine(:replace)
  end

  def address_info
    _info = {}
    self.class.address_columns.each do |address_column|
      _info[address_column] = self.send(address_column)
    end
    _info
  end

  def name_same?
    _user_shipping_address = user.user_shipping_address
    "#{_user_shipping_address.family_name}#{_user_shipping_address.first_name}" == "#{family_name}#{first_name}"
  end
  class_methods do
    def address_columns
      %i[
        first_name
        family_name
        first_name_kana
        family_name_kana
        zip
        pref
        city
        address
        building
        tel
        tel1
        tel2
        tel3
        sub_tel
        sub_tel1
        sub_tel2
        sub_tel3
      ]
    end
  end
end
