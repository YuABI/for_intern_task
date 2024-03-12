module Regex
  EMAIL = /\A[a-zA-Z0-9\.\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*\z/
  ZIP   = /\A\d{7}\z/
  NUM   = /\A[0-9]+\z/
  KANA  = /\A[ァ-ンー－　゛゜ヴ]+\z/
  TEL   = /\A\d{10}$|^\d{11}\z/
  CODE  = /\A[a-zA-Z0-9_\-\.]*\z/
end