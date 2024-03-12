module Import
  module Csv
    class UserImportService < Import::Csv::BaseImportService
      def target(row, _num)
        attr = {
          id: row[0],
          email: row[1],
        }
        user = User.alive_record_or_initialize_by(id: attr[:id])
        user.attributes = attr
        user.save
        user
      end

      def get_import_options
        self.import_options = {}
      end
    end
  end
end
