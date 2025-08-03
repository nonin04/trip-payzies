FactoryBot.define do
  sequence(:unique_name) { |n| "参加者#{n}" }

  factory :participant do
    name { generate(:unique_name) }
  end
end
