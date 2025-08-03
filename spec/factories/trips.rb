FactoryBot.define do
  factory :trip do
    association :user
    association :currency
    title { "旅行テスト" }
    departure_date { Date.today -1 }

    trait :with_participants do
      transient do
        participants_count { 10 }
      end
      after(:build) do |trip, evaluator|
        trip.participants_attributes = build_list(:participant, evaluator.participants_count).map(&:attributes)
      end
    end
    #----------------------------------------
    trait :trip_jpy do
      association :currency, factory: [ :currency, :jpy ]
      with_participants
    end

    trait :trip_usd do
      association :currency, factory: [ :currency, :usd ]
      with_participants
    end


    # バリデーションエラー検証--------------------------------------------------
    # 十人以上はエラー
    trait :participants_within_limit do
      with_participants
      transient do
        participants_count { 11 }
      end
    end

    trait :must_have_participant_at_least_one do
      with_participants
      transient do
        participants_count { 0 }
      end
    end
  end
end
