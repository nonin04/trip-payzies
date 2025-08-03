FactoryBot.define do
  factory :member do
    association :group
    name { "たかし" }
  end
end
