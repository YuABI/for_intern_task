class OperationCategory < Base::BasicActiveModel
  attr_accessor :id, :name, :code, :icon

  DATA_LIST = [
    { id: 300, code: 'user', icon: 'users', name: '顧客関連' },
    { id: 600, code: 'history', icon: 'play-circle', name: '実行履歴' },
    { id: 1000, code: 'setting', icon: 'tool', name: '各種設定' },
  ].freeze

  DATA_LIST.each do |code_data|
    define_method("#{code_data[:code]}?") do
      code == self.class.send(code_data[:code]).code
    end
  end

  def operations
    Operation.where(operation_category_id: id)
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
