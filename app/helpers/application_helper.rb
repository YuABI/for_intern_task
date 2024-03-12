module ApplicationHelper
  def space(cnt = 1)
    (1..cnt).map { |_i| '&nbsp;' }.join('').html_safe
  end
end
