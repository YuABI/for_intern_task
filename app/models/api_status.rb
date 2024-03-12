class ApiStatus < Base::BasicActiveModel
  attr_accessor :id, :name, :code

  DATA_LIST = [
    { id: 1, code: 'success', name: '成功' },
    { id: 2, code: 'failure', name: '失敗' },
  ].freeze

  DATA_LIST.each do |code_data|
    define_method("#{code_data[:code]}?") do
      code == self.class.send(code_data[:code]).code
    end
  end

  class << self
    def base_data
      DATA_LIST
    end
    DATA_LIST.each do |code_data|
      define_method("#{code_data[:code]}") do
        find_by(code: code_data[:code])
      end
    end
  end
end
