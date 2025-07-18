currencies = [
  { code: "JPY", ja_name: "日本円", en_name: "Japanese Yen", symbol: "¥" },
  { code: "EUR", ja_name: "ユーロ", en_name: "Euro", symbol: "€" },
  { code: "USD", ja_name: "米ドル", en_name: "US Dollar", symbol: "$" },

  # { code: "BGN", ja_name: "ブルガリアレフ", en_name: "Bulgarian Lev", symbol: "лв" },
  # { code: "CZK", ja_name: "チェココルナ", en_name: "Czech Koruna", symbol: "Kč" },
  # { code: "DKK", ja_name: "デンマーククローネ", en_name: "Danish Krone", symbol: "kr" },
  # { code: "GBP", ja_name: "英ポンド", en_name: "British Pound Sterling", symbol: "£" },
  # { code: "HUF", ja_name: "ハンガリーフォリント", en_name: "Hungarian Forint", symbol: "Ft" },
  # { code: "PLN", ja_name: "ポーランドズロチ", en_name: "Polish Zloty", symbol: "zł" },
  # { code: "RON", ja_name: "ルーマニアレイ", en_name: "Romanian Leu", symbol: "lei" },
  # { code: "SEK", ja_name: "スウェーデンクローナ", en_name: "Swedish Krona", symbol: "kr" },
  # { code: "CHF", ja_name: "スイスフラン", en_name: "Swiss Franc", symbol: "CHF" },
  # { code: "ISK", ja_name: "アイスランドクローナ", en_name: "Icelandic Króna", symbol: "kr" },
  # { code: "NOK", ja_name: "ノルウェークローネ", en_name: "Norwegian Krone", symbol: "kr" },
  # { code: "HRK", ja_name: "クロアチアクーナ", en_name: "Croatian Kuna", symbol: "kn" },
  # { code: "RUB", ja_name: "ロシアルーブル", en_name: "Russian Ruble", symbol: "₽" },
  # { code: "TRY", ja_name: "トルコリラ", en_name: "Turkish Lira", symbol: "₺" },
  # { code: "AUD", ja_name: "オーストラリアドル", en_name: "Australian Dollar", symbol: "A$" },
  # { code: "BRL", ja_name: "ブラジルレアル", en_name: "Brazilian Real", symbol: "R$" },
  # { code: "CAD", ja_name: "カナダドル", en_name: "Canadian Dollar", symbol: "C$" },
  # { code: "CNY", ja_name: "人民元", en_name: "Chinese Yuan", symbol: "¥" },
  # { code: "HKD", ja_name: "香港ドル", en_name: "Hong Kong Dollar", symbol: "HK$" },
  # { code: "IDR", ja_name: "インドネシアルピア", en_name: "Indonesian Rupiah", symbol: "Rp" },
  # { code: "ILS", ja_name: "イスラエル新シェケル", en_name: "Israeli New Shekel", symbol: "₪" },
  # { code: "INR", ja_name: "インドルピー", en_name: "Indian Rupee", symbol: "₹" },
  # { code: "KRW", ja_name: "韓国ウォン", en_name: "South Korean Won", symbol: "₩" },
  # { code: "MXN", ja_name: "メキシコペソ", en_name: "Mexican Peso", symbol: "Mex$" },
  # { code: "MYR", ja_name: "マレーシアリンギット", en_name: "Malaysian Ringgit", symbol: "RM" },
  # { code: "NZD", ja_name: "ニュージーランドドル", en_name: "New Zealand Dollar", symbol: "NZ$" },
  # { code: "PHP", ja_name: "フィリピンペソ", en_name: "Philippine Peso", symbol: "₱" },
  # { code: "SGD", ja_name: "シンガポールドル", en_name: "Singapore Dollar", symbol: "S$" },
  # { code: "THB", ja_name: "タイバーツ", en_name: "Thai Baht", symbol: "฿" },
  # { code: "ZAR", ja_name: "南アフリカランド", en_name: "South African Rand", symbol: "R" }
]

currencies.each do |c|
  Currency.create!(
    code: c[:code],
    ja_name: c[:ja_name],
    en_name: c[:en_name],
    symbol: c[:symbol]
  )
end