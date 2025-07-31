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
