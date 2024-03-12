class Array
  def to_lists(opt = {})
    self.map { |i| i.to_s.to_lists(opt) }.flatten
  end
end
