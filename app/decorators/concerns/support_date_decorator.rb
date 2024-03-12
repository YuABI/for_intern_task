module SupportDateDecorator
  extend ActiveSupport::Concern
  def strftime_at(sym, sep = ' ')
    self[sym].try(:strftime, "%Y-%m-%d#{sep}%H:%M:%S").to_s.html_safe
  end

  def short_date(sym, sep = '/')
    self[sym].try(:strftime, "%y#{sep}%m#{sep}%d").to_s.html_safe
  end

  def yyyymm_human(sym)
    "#{self[sym][0, 4]}年#{self[sym][4, 2]}月"
  end
end
