begin

  Trip.destroy_all
  User.destroy_all


userA = User.create!(
    name: "私はバリデーションの大魔王様だ",
    email: "example@email.com",
    password: "password"
  )

  trip1 = userA.trips.create!(
    title: "テスト旅行",
    departure_date: Date.today,
    participants_attributes: [
      { name: "参加者A" },
      { name: "参加者B" },
      { name: "参加者C" }
    ]
  )

  personA, personB, personC = trip1.participants.order(:id)

  # --------------expenseデータNo.1
  get_expense_by_personA = trip1.expenses.create!(
    payer: personA,
    amount: 5000,
    title: "ガソリン代",
    payment_date: Date.today,
    place: "東京都, 東京市",
    advance_payments_attributes: [
      { participant_id: personA.id },
      { participant_id: personB.id },
      { participant_id: personC.id }
    ]
  )
  ExpenseAmountDistributor.new(get_expense_by_personA).call

    # --------------expenseデータNo.2
  get_expense_by_personB = trip1.expenses.create!(
    payer: personB,
    amount: 5000,
    title: "ガソリン代2",
    payment_date: Date.today,
    place: "東京都, 東京市",
    advance_payments_attributes: [
      { participant_id: personB.id },
      { participant_id: personC.id }
    ]
  )
  ExpenseAmountDistributor.new(get_expense_by_personB).call











    trip2 = userA.trips.create!(
    title: "テスト旅行",
    departure_date: Date.today,
    participants_attributes: [
      { name: "参加者2A" },
      { name: "参加者2B" },
      { name: "参加者2C" },
      { name: "参加者2D" },
      { name: "参加者2E" }
    ]
  )
  person2A, person2B, person2C, person2D, person2E = trip2.participants.order(:id)

  # --------------expenseデータNo.2-1
  get_expense_by_person2A = trip2.expenses.create!(
    payer: person2A,
    amount: 5000,
    title: "ガソリン代",
    payment_date: Date.today,
    place: "東京都, 東京市",
    advance_payments_attributes: [
      { participant_id: person2A.id },
      { participant_id: person2B.id },
      { participant_id: person2C.id }
    ]
  )
  ExpenseAmountDistributor.new(get_expense_by_person2A).call



  rescue ActiveRecord::RecordInvalid => e
  puts "バリデーションエラー: #{e.record.errors.full_messages.join(', ')}"
  raise e
end


  # --------------------------------------------------------------------------