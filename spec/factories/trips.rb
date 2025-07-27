FactoryBot.define do
  factory :trip do
    title { "" }
    deperture_date { Date.today -1 }
  end
end
