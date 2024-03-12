# Abstract class for ActiveModel::Model
module Base
  class BasicActiveModel
    include ActiveModel::Model

    def attributes=(params)
      params.each do |k, v|
        send("#{k}=", v.html_safe)
      end
    end

    class << self
      def find(id)
        data = base_data.find { |i| i[:id] == id }
        return nil if data.blank?

        new(data)
      end

      def find_by(condition = {})
        data = base_data.find do |i|
          condition.find do |key, val|
            i[key] == val
          end
        end
        return nil if data.blank?

        new(data)
      end

      def all
        base_data.map do |data|
          new data
        end
      end

      def where(opt = {})
        all.reject { |data| opt.keys.map { |key| data.send(key) == opt[key] }.include?(false) }
      end

      def pluck(*column)
        all.map do |i|
          if column.is_a? Array
            column.map { |col| i.send(col) }
          else
            i.send(column)
          end
        end
      end
    end
  end
end
