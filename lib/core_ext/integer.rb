class Integer
  def percent_of(n)
    to_f / n.to_f * 100.0
  end

  def to_round(num, opt = {})
    return 0 if num.to_f.infinite? == 1
    return 0 if num.to_f.nan?

    num.round(opt[:round].blank? ? 2 : opt[:round].to_i)
  end
end
