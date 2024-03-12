module Export
  class BaseExportService
    def initialize(**options)
      @objects    = options[:objects]
      @file_path  = options[:file_path]
      @file_name  = @file_path.split('/').last
    end

    def header_objects(csv_object)
      raise NotImplementedError
    end

    def body_objects(csv_object)
      raise NotImplementedError
    end
    attr_reader :objects, :file_path, :file_name
  end
end
