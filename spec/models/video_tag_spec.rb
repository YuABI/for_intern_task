# == Schema Information
#
# Table name: video_tags
#
#  id         :bigint           not null, primary key
#  deleted    :integer
#  deleted_at :datetime
#  tag_name   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe VideoTag, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
