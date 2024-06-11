require 'rails_helper'

RSpec.describe UserLifeplan::YearlyBalance, type: :model do
  describe '.calculate' do
    subject { yearly_balance.calculate }
    let(:yearly_balance) { described_class.new(user_lifeplan_id: user_lifeplan.id) }
    let(:user_lifeplan) { create(:user_lifeplan) }

  end
end

