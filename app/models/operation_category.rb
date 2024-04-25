class OperationCategory < Base::BasicActiveModel
  attr_accessor :id, :name, :code, :icon

  DATA_LIST = [
    { id: 100, code: 'user',     icon: 'users',       name: '顧客' },
    { id: 200, code: 'member',   icon: 'award',       name: '会員・パートナー' },
    { id: 300, code: 'invoice',  icon: 'credit-card', name: '請求書' },
    { id: 400, code: 'plan',     icon: 'calendar',    name: 'プラン関連' },
    { id: 500, code: 'content',  icon: 'book-open',   name: 'コンテンツ関連' },
    # { id: 600, code: 'history', icon: 'play-circle', name: '実行履歴' },
    { id: 1000, code: 'setting', icon: 'tool',        name: '各種設定' },
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
