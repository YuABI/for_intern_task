class UserLifeplanFinanceConditionStatus < ActiveHash::Base
  self.data = [
    { id: 1, name: '審査中', code: 'checking'},
    { id: 2, name: '承認', code: 'approved'},
    { id: 3, name: '却下', code: 'rejected'}
  ]

  def checking?
    id == 1
  end

  def approved?
    id == 2
  end

  def rejected?
    id == 3
  end
end

