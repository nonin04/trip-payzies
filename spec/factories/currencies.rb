FactoryBot.define do
  factory :currency do
    code { "JPY" }
    ja_name { "日本円" }
    en_name { "Japanese Yen" }
    symbol { "¥" }
    decimal_position { 0 }
#----------------------------------
    trait :jpy do
      code { "JPY" }
      ja_name { "日本円" }
      en_name { "Japanese Yen" }
      symbol { "¥" }
      decimal_position { 0 }
    end

    trait :usd do
      code { "USD" }
      ja_name { "米ドル" }
      en_name { "US Dollar" }
      symbol { "$" }
      decimal_position { 2 }
    end
  end
end




#   { code: "JPY", ja_name: "日本円", en_name: "Japanese Yen", symbol: "¥", decimal_position: 0 },
# schema
# create_table "currencies", force: :cascade do |t|
#   t.string "code", null: false
#   t.string "ja_name", null: false
#   t.string "en_name", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.string "symbol"
#   t.integer "decimal_position", default: 0, null: false
# end
