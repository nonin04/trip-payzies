FactoryBot.define do
  factory :trip do
    association :currency
    association :currency, factory: [ :currency, :jpy ]
    title { "" }
    deperture_date { Date.today -1 }

    trait :trip_jpy do
      association :currency, factory: [ :currency, :jpy ]
      title { "" }
      deperture_date { Date.today -1 }
    end
  end
end
