#
# README:
#
# - gem 'moji'必須
#

class String
  # 半角数字
  def number?
    self =~ /\A-?\d+\Z/
  end

  # 半角全角数字
  def all_number?
    self =~ /\A-?[0-9０-９]+\Z/
  end

  def to_lists(_opt = {})
    split_sym = '$$'
    _str      = self
    _lists = [_str]
    _lists.map do |i|
      i.to_s.gsub('、', split_sym).gsub('､', split_sym).gsub(',', split_sym).gsub(/(\r\n|\r|\n)/, split_sym)
    end
      .join(split_sym).split(split_sym).map { |i| i.presence }.compact
  end

  def allow_to_date?
    return false if self.blank?

    tmp_date_arr = self.to_s.split('-')
    Date.valid_date?(tmp_date_arr[0].to_i, tmp_date_arr[1].to_i, tmp_date_arr[2].to_i)
  end

  def remove_indent
    gsub(/(\r\n|\r|\n)/, '')
  end

  def remove_space
    gsub(' ', '').gsub('　', '')
  end

  def to_katakana
    tr('ぁ-ん', 'ァ-ン')
  end

  def to_hiragana
    tr('ァ-ン', 'ぁ-ん')
  end

  # 全角を半角に変換
  def to_hankaku
    Moji.zen_to_han(self)
  end

  # 半角を全角に変換
  def to_zenkaku
    Moji.han_to_zen(
      Moji.han_to_zen(
        Moji.han_to_zen(
          Moji.han_to_zen(
            self, Moji::HAN_ALPHA
          ), Moji::HAN_KATA
        ), Moji::HAN_ASYMBOL
      ), Moji::HAN_NUMBER
    )
  end

  def to_katakana_zenkaku
    to_zenkaku.to_katakana
  end

  def to_hiragana_zenkaku
    to_zenkaku.to_hiragana
  end

  def text_sub(sym1 = /(\n)/, sym2 = '<br />')
    gsub(sym1, sym2)
  end

  # 文字が多いとき"..."を付ける
  def text_abbr(len, sym = '...')
    txt = to_zenkaku
    text = text.delete(' ').gsub(/<br>/i, ' ').gsub(%r{<br/>}i, ' ')
    return '' if text.nil?
    return text if text.jlength < len

    text.scan(/^.{#{len}}/m)[0] + sym
  end

  # 全角を半角に変換
  def to_email
    Moji.zen_to_han(Moji.downcase(to_s))
  end

  def replace_address_format
    remove_space.gsub('-', '－').gsub('−', '－')
  end
end
