FactoryBot.define do
  factory :advance_payment do
    amount { 1000 }
    association :expense
    association :participant
  end
end
