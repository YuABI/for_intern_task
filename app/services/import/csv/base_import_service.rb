module Import
  module Csv
    class BaseImportService < Import::BaseImportService
      def call
        if import_file.blank?
          self.errors.add(:base, 'ファイルを指定してください')
          return false
        end
        unless File.extname(import_file.original_filename) == '.csv'
          self.errors.add(:base, 'csv形式のファイルを取り込んでください')
          return false
        end
        _errors = ApplicationRecord.standard_transaction do
          open(import_file.path, 'rb:Shift_JIS:UTF-8', undef: :replace) do |f|
            CSV.new(f, col_sep: ',').each_with_index do |row, i|
              next if use_header && i == 0

              target_object = target(row, i)
              result_code = :success
              if target_object.errors.present?
                result_code = :error
                self.errors.add(:base, "#{i + 1}行：#{target_object.generate_error_messages.join(' / ')}")
              end
              self.import_results[result_code] << target_object
            end
          end
          raise 'import error' if self.import_results[:error].present?
        end

        _errors.blank?
      end

      def get_import_options
        self.import_options = {}
      end

      def use_header
        true
      end
    end
  end
end
