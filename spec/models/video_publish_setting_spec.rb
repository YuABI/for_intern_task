# == Schema Information
#
# Table name: video_publish_settings
#
#  id         :bigint           not null, primary key
#  deleted    :integer
#  deleted_at :datetime
#  setting    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe VideoPublishSetting, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
