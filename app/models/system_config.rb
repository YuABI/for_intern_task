# == Schema Information
#
# Table name: system_configs
#
#  id                   :bigint           not null, primary key
#  deleted(削除区分)    :integer          default(0), not null
#  deleted_at(削除日時) :datetime
#  site_url(サイトURL)  :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_system_configs_on_deleted  (deleted)
#
class SystemConfig < ApplicationRecord
  composed_of_url(:composed_site_url, 'my_site_url')
  # アカウント休止
  def secure_site_url
    composed_site_url.secure_url
  end

  def tel_lengths = [10, 11]
  def mobile_heads = %w[090 080 070 060 050]
  def mobile_length = 11

  class << self
    def permit_params
      super + []
    end

    def target_record(select_option = nil)
      _target_records = alive_records
      _target_records = _target_records.select(select_option) if select_option
      _target_records.first.decorate
    end

    def choice_wdays
      {
        1 => '月',
        2 => '火',
        3 => '水',
        4 => '木',
        5 => '金',
        6 => '土',
        0 => '日',
      }
    end
  end
end
