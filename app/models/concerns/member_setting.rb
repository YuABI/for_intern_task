module MemberSetting
  extend ActiveSupport::Concern
  included do
    belongs_to :member
  end
  class_methods do
    def member_alive_record(member_,opt={})
      opt[:member] = member_.id  if self.column_names.include?("member_id")
      alive_record(opt)
    end
    def member_custom_find_by(member_,opt={},attr={})
      object =  custom_find_by(opt,attr)
      return nil unless object
      if self.column_names.include?("member_id")
        return nil unless object.try(:member_id) == member_.id
      end
      if object.try(:is_a?,Member)
        return nil unless object.try(:id) == member_.id
      end
      object.attributes = attr || {}
      object
    end
    def member_alive_records(member_)
      records_ = alive_records
      if self.column_names.include?("member_id") && member_.present?
        records_ = records_.where(member_id: member_.id)
      end
      return records_
    end
    def member_new_record(member_, opt={})
      opt[:member_id] =  member_.id  if self.column_names.include?("member_id")
      model_ = self.new(opt)
      return model_
    end


  end
end
