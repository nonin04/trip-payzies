FactoryBot.define do
  factory :expense do
    association :trip
    association :currency
    title { "立替テスト" }
    amount_local { 1000 }
    payment_date { Date.today -1 }

    trait :with_advance_payments do
      transient do
        advance_payments_count { 10 }
      end
      after(:build) do |expense, evaluator|
        trip = expense.trip
        selected_participants = trip.participants.take(evaluator.advance_payments_count)
        expense.advance_payments_attributes = selected_participants.map do |participant|
          build(:advance_payment, expense: expense, participant: participant).attributes
        end
      end
    end

    # _evaluatorで一時データを使わないことを明示
    trait :with_payer do
      after(:build) do |expense, _evaluator|
        expense.payer = expense.trip.participants.sample
      end
    end

    # 通貨の日付検証用----------------------------------------
    trait :usd_date_too_old do
      association :currency, :usd
      payment_date { Date.new(2025, 7, 18) }
      with_advance_payments
      with_payer
    end

    trait :usd_in_future_date do
      association :currency, :usd
      payment_date { Date.today + 2 }
      with_advance_payments
      with_payer
    end

    trait :jpy_date_too_old do
      association :currency, :jpy
      payment_date { Date.new(2025, 7, 18) }
      with_advance_payments
      with_payer
    end

    trait :jpy_in_future_date do
      association :currency, :jpy
      payment_date { Date.today + 1 }
      with_advance_payments
      with_payer
    end

    # 対象者、決済者のバリデーション--------------------------------------------------
    trait :payer_null do
      with_advance_payments
      after(:build) do |expense, _evaluator|
        expense.payer = nil
      end
    end

    trait :advance_payments_null do
      after(:build) do |expense, _evaluator|
        expense.advance_payments_attributes = []
      end
      with_payer
    end
  end
end
