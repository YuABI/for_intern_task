module Import
  class BaseImportService
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :import_file
    attribute :import_options
    attribute :import_objects
    attribute :import_results

    def initialize(attributes = {})
      super(attributes)
      get_import_options
      self.import_objects = []
      self.import_results = { success: [], error: [] }
    end

    def generate_error_messages
      self.errors.messages.map do |_message|
        self.errors.full_messages_for(_message.first)
      end.compact.flatten
    end

    def success_count
      import_results[:success].size
    end

    def error_count
      import_results[:error].size
    end

    def total_count
      success_count + error_count
    end
    class << self
      def permit_params
        [
          :import_file,
        ]
      end
    end
  end
end
