class UserLifeplanFinanceConditionStatus < ActiveHash::Base
  self.data = [
    { id: 1, name: '審査中', code: 'checking'},
    { id: 2, name: '承認', code: 'approved'},
    { id: 3, name: '却下', code: 'rejected'}
  ]

  class << self
    def checking() 1; end
    def approved() 2; end
    def rejected() 3; end
  end

  def code
    self[:code]
  end

  def checking?
    id == self.class.checking
  end

  def approved?
    id == self.class.approved
  end

  def rejected?
    id == self.class.rejected
  end
end

