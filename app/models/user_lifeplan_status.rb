class UserLifeplanStatus < ActiveHash::Base
  self.data = [
    { id: 1, name: '入力中', code: 'entering'},
    { id: 2, name: '本部審査待ち', code: 'check_pending'},
    { id: 3, name: '本部審査完了', code: 'check_completed'}
  ]
  class << self
    def entering() 1;end
    def check_pending() 2;end
    def check_completed() 3;end
  end

  def entering?
    id == self.class.entering()
  end

  def check_pending?
    id == self.class.check_pending()
  end

  def check_completed?
    id == self.class.check_completed()
  end
end
