class UserLifeplanStatus < ActiveHash::Base
  self.data = [
    { id: 1, name: '入力中' },
    { id: 2, name: '本部審査待ち' },
    { id: 3, name: '本部審査中' },
    { id: 4, name: '本部審査完了' }
  ]

  def entering?
    id == 1
  end

  def check_pending?
    id == 2
  end

  def checking?
    id == 3
  end

  def check_completed?
    id == 4
  end
end
