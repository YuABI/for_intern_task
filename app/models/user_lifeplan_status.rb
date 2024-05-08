class UserLifeplanStatus < ActiveHash::Base
  self.data = [
    { id: 1, name: '入力中', code: 'entering'},
    { id: 2, name: '本部審査待ち', code: 'check_pending'},
    { id: 3, name: '本部審査完了', code: 'check_completed'}
  ]

  def entering?
    id == 1
  end

  def check_pending?
    id == 2
  end

  def check_completed?
    id == 3
  end
end
