module Export
  module Csv
    class UserExportService < Export::Csv::BaseExportService
      def initialize(**options)
        options[:file_path] = FileCreateUtil.create_file_name(name: 'users')
        super(**options)
      end

      def header_objects(csv_object)
        header = [
          User.human(:id),
          User.human(:email),
          User.human(:sex),
          User.human(:birthday),
          User.human(:last_logined_at),
          Address.human(:family_name),
          Address.human(:first_name),
          Address.human(:family_name_kana),
          Address.human(:first_name_kana),
          Address.human(:zip),
          Address.human(:pref),
          Address.human(:city),
          Address.human(:address1),
          Address.human(:address2),
          Address.human(:tel),
        ]
        csv_object << header
        csv_object
      end

      def body_objects(csv_object)
        objects.each do |object|
          object       = object.decorate
          user_address = object.user_address
          body = [
            object.id,
            object.email,
            object.sex.text,
            object.birthday,
            object.strftime_at(:last_logined_at),
            user_address.family_name,
            user_address.first_name,
            user_address.family_name_kana,
            user_address.first_name_kana,
            user_address.zip,
            user_address.pref,
            user_address.city,
            user_address.address1,
            user_address.address2,
            user_address.tel,
          ]
          csv_object << body
        end
        csv_object
      end
    end
  end
end
