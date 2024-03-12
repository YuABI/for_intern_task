# == Schema Information
#
# Table name: zip_lists
#
#  id         :bigint           not null, primary key
#  address    :string
#  city       :string
#  city_en    :string
#  city_kana  :string
#  pref       :string
#  pref_en    :string
#  pref_kana  :string
#  town       :string
#  town_en    :string
#  town_kana  :string
#  zip        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_zip_lists_on_pref  (pref)
#  index_zip_lists_on_zip   (zip)
#
#
class ZipList < ApplicationRecord
  def join_address
    "#{pref}#{city}#{town.to_s.split('（').first}"
  end
  class << self
    def exclusion_lists
      ['（その他）']
    end

    def find_address(zip_num)
      list = find_by(zip: zip_num.to_i)
      return nil unless list

      new_town = list.town.to_s
      exclusion_lists.each do |i|
        new_town.gsub!(i, '')
      end
      if list.town.include?('（')
        list.town      = list.town.gsub(/（.*/m, '')
        list.address   = list.address.gsub(/（.*/m, '')
        list.town_kana = list.town_kana.gsub(/\(.*/m, '')
      end

      if list.town.include?('以下に掲載がない場合')
        list.town      = list.town.gsub(/以下.*/m, '')
        list.town_kana = list.town_kana.gsub(/ｲｶ.*/m, '')
        list.address   = list.address.gsub(/以下.*/m, '')
      end
      list.town = new_town
      list
    end

    def import_zip_list(file, batch: false)
      standard_transaction do
        ZipList.delete_all
        file_format = batch ? file : file.path
        File.open(file_format, 'rb:Shift_JIS:UTF-8', undef: :replace) do |f|
          CSV.new(f, col_sep: ',').each_slice(1000) do |batch|
            zip_lists = []

            batch.each do |row|
              attributes = { zip: row[2],
                             pref_kana: row[3],
                             city_kana: row[4],
                             town_kana: row[5],
                             pref: row[6],
                             city: row[7],
                             town: row[8],
                             address: "#{row[6]}#{row[7]}#{row[8]}" }

              zip_lists << new(attributes)
            end

            ZipList.import zip_lists
          end
        end
      end
    end

    def permit_params
      column_names
    end
  end
end
