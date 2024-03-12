module Base
  class BasicView < ApplicationRecord
    self.abstract_class = true
    class << self
    end
  end
end
