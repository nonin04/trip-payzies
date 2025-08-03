FactoryBot.define do
  factory :exchange_rate do
    association :currency, factory: [ :currency, :jpy ]
    rate { 1 }
    rate_date { Date.today }
    #----------------------------------
    trait :jpy_today do
    end

    trait :jpy_yesterday do
    end

    trait :usd_today do
      association :currency, factory: [ :currency, :usd ]
      rate { 0.00672744 }
      rate_date { Date.today }
    end

    trait :usd_yesterday do
      association :currency, factory: [ :currency, :usd ]
      rate { 0.00680042 }
      rate_date { Date.today - 1 }
    end


# #--------------------------------------------------------
#     #7/19以前を選択しても問題ない
#     trait :jpy_nineteen_before do
#       rate_date { Date.new(2025, 7, 18)}
#     end

#     #7/19以前を選択するとエラー
#     trait :usd_nineteen_before do
#       rate_date { Date.new(2025, 7, 18)}
#     end
  end
end
