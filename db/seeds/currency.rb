# currencies = [
#   # 日本人観光客数上位 20通貨
#   { code: "JPY", ja_name: "日本円", en_name: "Japanese Yen", symbol: "¥", decimal_position: 0 },
#   { code: "KRW", ja_name: "韓国ウォン", en_name: "South Korean Won", symbol: "₩", decimal_position: 0 },
#   { code: "TWD", ja_name: "ニュー台湾ドル", en_name: "New Taiwan Dollar", symbol: "NT$", decimal_position: 2 },
#   { code: "CNY", ja_name: "中国元", en_name: "Chinese Yuan", symbol: "¥", decimal_position: 2 },
#   { code: "USD", ja_name: "米ドル", en_name: "US Dollar", symbol: "$", decimal_position: 2 },
#   { code: "THB", ja_name: "タイバーツ", en_name: "Thai Baht", symbol: "฿", decimal_position: 2 },
#   { code: "HKD", ja_name: "香港ドル", en_name: "Hong Kong Dollar", symbol: "$", decimal_position: 2 },
#   { code: "PHP", ja_name: "フィリピンペソ", en_name: "Philippine Peso", symbol: "₱", decimal_position: 2 },
#   { code: "VND", ja_name: "ベトナムドン", en_name: "Vietnamese Dong", symbol: "₫", decimal_position: 0 },
#   { code: "SGD", ja_name: "シンガポールドル", en_name: "Singapore Dollar", symbol: "$", decimal_position: 2 },
#   { code: "MYR", ja_name: "マレーシアリンギット", en_name: "Malaysian Ringgit", symbol: "RM", decimal_position: 2 },
#   { code: "EUR", ja_name: "ユーロ", en_name: "Euro", symbol: "€", decimal_position: 2 },
#   { code: "IDR", ja_name: "インドネシアルピア", en_name: "Indonesian Rupiah", symbol: "Rp", decimal_position: 0 },
#   { code: "AUD", ja_name: "オーストラリアドル", en_name: "Australian Dollar", symbol: "$", decimal_position: 2 },
#   { code: "GBP", ja_name: "英ポンド", en_name: "British Pound Sterling", symbol: "£", decimal_position: 2 },
#   { code: "NZD", ja_name: "ニュージーランドドル", en_name: "New Zealand Dollar", symbol: "$", decimal_position: 2 },
#   { code: "CAD", ja_name: "カナダドル", en_name: "Canadian Dollar", symbol: "$", decimal_position: 2 },
#   { code: "INR", ja_name: "インドルピー", en_name: "Indian Rupee", symbol: "₹", decimal_position: 2 },
#   { code: "ZAR", ja_name: "南アフリカランド", en_name: "South African Rand", symbol: "R", decimal_position: 2 },
#   { code: "BRL", ja_name: "ブラジルレアル", en_name: "Brazilian Real", symbol: "R$", decimal_position: 2 },
#   # その他通貨（アルファベット順）
#   { code: "AED", ja_name: "アラブ首長国連邦ディルハム", en_name: "United Arab Emirates Dirham", symbol: "د.إ", decimal_position: 2 },
#   { code: "ARS", ja_name: "アルゼンチンペソ", en_name: "Argentine Peso", symbol: "$", decimal_position: 2 },
#   { code: "AZN", ja_name: "アゼルバイジャンマナト", en_name: "Azerbaijani Manat", symbol: "₼", decimal_position: 2 },
#   { code: "BGN", ja_name: "ブルガリアレフ", en_name: "Bulgarian Lev", symbol: "лв", decimal_position: 2 },
#   { code: "BHD", ja_name: "バーレーンディナール", en_name: "Bahraini Dinar", symbol: ".د.ب", decimal_position: 3 },
#   { code: "CHF", ja_name: "スイスフラン", en_name: "Swiss Franc", symbol: "CHF", decimal_position: 2 },
#   { code: "CLP", ja_name: "チリペソ", en_name: "Chilean Peso", symbol: "$", decimal_position: 0 },
#   { code: "COP", ja_name: "コロンビアペソ", en_name: "Colombian Peso", symbol: "$", decimal_position: 2 },
#   { code: "CZK", ja_name: "チェココルナ", en_name: "Czech Republic Koruna", symbol: "Kč", decimal_position: 2 },
#   { code: "DKK", ja_name: "デンマーククローネ", en_name: "Danish Krone", symbol: "kr", decimal_position: 2 },
#   { code: "DOP", ja_name: "ドミニカペソ", en_name: "Dominican Peso", symbol: "RD$", decimal_position: 2 },
#   { code: "EGP", ja_name: "エジプトポンド", en_name: "Egyptian Pound", symbol: "£", decimal_position: 2 },
#   { code: "HUF", ja_name: "ハンガリーフォリント", en_name: "Hungarian Forint", symbol: "Ft", decimal_position: 0 },
#   { code: "ILS", ja_name: "イスラエル新シェケル", en_name: "Israeli New Sheqel", symbol: "₪", decimal_position: 2 },
#   { code: "KES", ja_name: "ケニアシリング", en_name: "Kenyan Shilling", symbol: "KSh", decimal_position: 2 },
#   { code: "KWD", ja_name: "クウェートディナール", en_name: "Kuwaiti Dinar", symbol: "د.ك", decimal_position: 3 },
#   { code: "MXN", ja_name: "メキシコペソ", en_name: "Mexican Peso", symbol: "$", decimal_position: 2 },
#   { code: "NOK", ja_name: "ノルウェークローネ", en_name: "Norwegian Krone", symbol: "kr", decimal_position: 2 },
#   { code: "OMR", ja_name: "オマーンリアル", en_name: "Omani Rial", symbol: "ر.ع.", decimal_position: 3 },
#   { code: "PEN", ja_name: "ペルー新ソル", en_name: "Peruvian Nuevo Sol", symbol: "S/.", decimal_position: 2 },
#   { code: "PKR", ja_name: "パキスタンルピー", en_name: "Pakistani Rupee", symbol: "₨", decimal_position: 2 },
#   { code: "PLN", ja_name: "ポーランドズウォティ", en_name: "Polish Zloty", symbol: "zł", decimal_position: 2 },
#   { code: "QAR", ja_name: "カタールリアル", en_name: "Qatari Rial", symbol: "ر.ق", decimal_position: 2 },
#   { code: "RON", ja_name: "ルーマニアレウ", en_name: "Romanian Leu", symbol: "L", decimal_position: 2 },
#   { code: "RSD", ja_name: "セルビアディナール", en_name: "Serbian Dinar", symbol: "дин.", decimal_position: 2 },
#   { code: "RUB", ja_name: "ロシアルーブル", en_name: "Russian Ruble", symbol: "₽", decimal_position: 2 },
#   { code: "SAR", ja_name: "サウジリアル", en_name: "Saudi Riyal", symbol: "ر.س", decimal_position: 2 },
#   { code: "SEK", ja_name: "スウェーデンクローナ", en_name: "Swedish Krona", symbol: "kr", decimal_position: 2 },
#   { code: "TND", ja_name: "チュニジアディナール", en_name: "Tunisian Dinar", symbol: "د.ت", decimal_position: 3 },
#   { code: "TRY", ja_name: "トルコリラ", en_name: "Turkish Lira", symbol: "₺", decimal_position: 2 },
#   { code: "UAH", ja_name: "ウクライナフリヴニャ", en_name: "Ukrainian Hryvnia", symbol: "₴", decimal_position: 2 },
#   { code: "UYU", ja_name: "ウルグアイペソ", en_name: "Uruguayan Peso", symbol: "$", decimal_position: 2 },
#   { code: "ZMW", ja_name: "ザンビアクワチャ", en_name: "Zambian Kwacha", symbol: "ZK", decimal_position: 2 }
# ]

# currencies.each do |c|
#   Currency.find_or_create_by!(code: c[:code]) do |currency|
#     currency.ja_name = c[:ja_name]
#     currency.en_name = c[:en_name]
#     currency.symbol = c[:symbol]
#     currency.decimal_position = c[:decimal_position]
#   end
# end
