FactoryBot.define do
  factory :exchange_rate do
    association :currency, factory: [ :currency, :jpy ]
    rate { 1 }
    rate_date { Date.today }
    
    #----------------------------------
    trait :jpy_today do
      association :currency, factory: [ :currency, :jpy ]
      rate { 1 }
      rate_date { Date.today }
    end

    trait :jpy_yesterday do
      association :currency, factory: [ :currency, :jpy ]
      rate { 1 }
      rate_date { Date.today - 1 }
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
  end
end
