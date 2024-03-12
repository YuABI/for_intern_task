# 端数処理を計算する
class FileCreateUtil
  class << self
    def create_dir(tmp_dir)
      unless File.exist?(tmp_dir)
        FileUtils.mkdir_p tmp_dir
        s = File.stat(Rails.root)
        File.chown(s.uid, s.gid, tmp_dir)
      end
      tmp_dir
    end

    def create_file_name(**args)
      name    = args[:name]
      format  = args[:format] || :csv
      "#{file_tmp}#{name + file_name_format}.#{format}"
    end

    def file_name_format
      Time.now.strftime('%Y%m%d-%H%M%S')
    end

    def file_tmp(add_dir = '')
      create_dir("#{Rails.root.join("#{file_info[:tmp].join('/')}/#{"#{add_dir}/" if add_dir.present?}")}")
    end

    def file_info(_add_dir = '')
      {
        tmp: %w[tmp file],
      }
    end
  end
end
