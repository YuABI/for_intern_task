module Export
  module Csv
    class BaseExportService < Export::BaseExportService
      require 'csv'

      def initialize(**options)
        super(**options)
        @encoding   = options[:encoding]  || 'CP932:UTF-8'
        @row_sep    = options[:row_sep]   || "\r\n"
      end

      def call
        CSV.open(file_path, 'w', encoding:, row_sep:, invalid: :replace,
                                 undef: :replace) do |csv|
          header_objects(csv)
          body_objects(csv)
        end
      end

      attr_reader :encoding, :row_sep
    end
  end
end
