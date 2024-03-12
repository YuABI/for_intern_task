class EmailValue < ApplicationValueObject
  attribute :email_value, :string

  def to_s
    email_value
  end

  def split_value
    email_value.split('@')
  end

  def account
    split_value.last
  end

  def domain
    split_value.last
  end

  def carrier?
    CARRIER_DOMAIN.include?(domain)
  end

  CARRIER_DOMAIN = [
    'docomo.ne.jp',
    'ezweb.ne.jp',
    'softbank.ne.jp',
    'd.vodafone.ne.jp',
    'h.vodafone.ne.jp',
    't.vodafone.ne.jp',
    'c.vodafone.ne.jp',
    'k.vodafone.ne.jp',
    'q.vodafone.ne.jp',
    'n.vodafone.ne.jp',
    's.vodafone.ne.jp',
    'r.vodafone.ne.jp',
    'jp-d.ne.jp',
    'jp-h.ne.jp',
    'jp-t.ne.jp',
    'jp-c.ne.jp',
    'jp-k.ne.jp',
    'jp-q.ne.jp',
    'jp-n.ne.jp',
    'jp-s.ne.jp',
    'jp-r.ne.jp',
    'pdx.ne.jpx',
    'di.pdx.ne.jp',
    'dj.pdx.ne.jp',
    'dk.pdx.ne.jp',
    'wm.pdx.ne.jp',
    'willcom.com',
    'emnet.ne.jp',
    'disney.ne.jp',
    'mopera.ne.jp',
    'i.softbank.jp',
  ]
end
