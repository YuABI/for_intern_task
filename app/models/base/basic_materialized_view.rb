module Base
  class BasicMaterializedView < ApplicationRecord
    self.abstract_class = true
    class << self
      # このメソッドを実行するとマテリアライズド・ビューが更新される
      def refresh
        Scenic.database.refresh_materialized_view(table_name, concurrently: true)
      end
    end
  end
end
