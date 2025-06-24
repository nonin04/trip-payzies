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





# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------



    trip2 = userA.trips.create!(
    title: "Kyoto Trip (sample)",
    departure_date: Date.new(2025, 7, 1),
    participants_attributes: [
      { name: "Alice" },
      { name: "Bob" },
      { name: "Charlie" },
      { name: "Diana" },
      { name: "Ethan" },
      { name: "Fiona" },
      { name: "George" },
      { name: "Hannah" }
    ]
  )
  pA, pB, pC, pD, pE, pF, pG, pH = trip2.participants.order(:id)

  # --------------expenseデータNo.2-1
  get_expense_by_pA = trip2.expenses.create!(
    payer: pA,
    amount: 2674,
    title: "Snacks & Drinks",
    payment_date: Date.new(2025, 7, 1),
    advance_payments_attributes: [
      { participant_id: pC.id },
      { participant_id: pE.id },
      { participant_id: pF.id },
      { participant_id: pG.id },
      { participant_id: pH.id }
    ]
  )
  ExpenseAmountDistributor.new(get_expense_by_pA).call
  # --------------expenseデータNo.2-2
  get_expense_by_pF = trip2.expenses.create!(
    payer: pF,
    amount: 28630,
    title: "Rental Car",
    payment_date: Date.new(2025, 7, 1),
    advance_payments_attributes: [
      { participant_id: pA.id },
      { participant_id: pB.id },
      { participant_id: pC.id },
      { participant_id: pD.id },
      { participant_id: pE.id },
      { participant_id: pF.id },
      { participant_id: pG.id },
      { participant_id: pH.id }
    ]
  )
  ExpenseAmountDistributor.new(get_expense_by_pF).call
  # --------------expenseデータNo.2-3
  get_expense_by_pG = trip2.expenses.create!(
    payer:pG,
    amount: 1200,
    title: "Parking Fees",
    payment_date: Date.new(2025, 7, 2),
    advance_payments_attributes: [
      { participant_id: pA.id },
      { participant_id: pB.id },
      { participant_id: pC.id },
      { participant_id: pD.id },
      { participant_id: pE.id },
      { participant_id: pF.id },
      { participant_id: pH.id }
    ]
  )
  ExpenseAmountDistributor.new(get_expense_by_pG).call
  # --------------expenseデータNo.2-4
  get_expense_by_pE = trip2.expenses.create!(
    payer: pE,
    amount: 76400,
    title: "Hotel Accommodation",
    payment_date: Date.new(2025, 7, 3),
    advance_payments_attributes: [
      { participant_id: pA.id },
      { participant_id: pF.id },
      { participant_id: pG.id },
      { participant_id: pH.id }
    ]
  )
  ExpenseAmountDistributor.new(get_expense_by_pE).call
  # --------------expenseデータNo.2-5
  get_expense_by_pB = trip2.expenses.create!(
    payer: pB,
    amount: 9210,
    title: "Souvenirs",
    payment_date: Date.new(2025, 7, 4),
    advance_payments_attributes: [
      { participant_id: pB.id },
      { participant_id: pD.id }
    ]
  )
  ExpenseAmountDistributor.new(get_expense_by_pB).call
  # --------------expenseデータNo.2-6
  get_expense_by_pC = trip2.expenses.create!(
    payer:pC,
    amount: 20670,
    title: "Bento Lunch",
    payment_date: Date.new(2025, 7, 5),
    advance_payments_attributes: [
      { participant_id: pB.id },
      { participant_id: pC.id },
      { participant_id: pD.id },
      { participant_id: pE.id },
      { participant_id: pF.id },
      { participant_id: pG.id },
      { participant_id: pH.id }
    ]
  )
  ExpenseAmountDistributor.new(get_expense_by_pC).call
  # --------------expenseデータNo.2-7
  get_expense_by_pF2 = trip2.expenses.create!(
    payer: pF,
    amount: 73500,
    title: "Kimono rental",
    payment_date: Date.new(2025, 7, 6),
    advance_payments_attributes: [
      { participant_id: pA.id },
      { participant_id: pB.id },
      { participant_id: pC.id },
      { participant_id: pD.id },
      { participant_id: pE.id },
      { participant_id: pF.id },
      { participant_id: pG.id },
      { participant_id: pH.id }
    ]
  )
  ExpenseAmountDistributor.new(get_expense_by_pF2).call
  # --------------expenseデータNo.2-8
  get_expense_by_pB2 = trip2.expenses.create!(
    payer: pB,
    amount: 29100,
    title: "Shinkansen chickets",
    payment_date: Date.new(2025, 7, 7),
    advance_payments_attributes: [
      { participant_id: pD.id },
      { participant_id: pE.id }
    ]
  )
  ExpenseAmountDistributor.new(get_expense_by_pB2).call
  # --------------expenseデータNo.2-9
  get_expense_by_pC2 = trip2.expenses.create!(
    payer: pC,
    amount: 4850,
    title: "Gasoline",
    payment_date: Date.new(2025, 7, 8),
    advance_payments_attributes: [
      { participant_id: pA.id },
      { participant_id: pB.id },
      { participant_id: pC.id },
      { participant_id: pD.id },
      { participant_id: pE.id },
      { participant_id: pF.id },
      { participant_id: pG.id },
      { participant_id: pH.id }
    ]
  )
  ExpenseAmountDistributor.new(get_expense_by_pC2).call
  # --------------expenseデータNo.2-10
  get_expense_by_pG2 = trip2.expenses.create!(
    payer: pG,
    amount: 3400,
    title: "Ramen",
    payment_date: Date.new(2025, 7, 9),
    advance_payments_attributes: [
      { participant_id: pE.id },
      { participant_id: pF.id },
      { participant_id: pH.id }
    ]
  )
  ExpenseAmountDistributor.new(get_expense_by_pG2).call
  # --------------expenseデータNo.2-11
  get_expense_by_pE2 = trip2.expenses.create!(
    payer: pE,
    amount: 29400,
    title: "Dinner at Izakaya",
    payment_date: Date.new(2025, 7, 10),
    advance_payments_attributes: [
      { participant_id: pA.id },
      { participant_id: pC.id },
      { participant_id: pF.id },
      { participant_id: pG.id },
      { participant_id: pH.id }
    ]
  )
  ExpenseAmountDistributor.new(get_expense_by_pE2).call
  # --------------expenseデータNo.2-12
  get_expense_by_pH = trip2.expenses.create!(
    payer: pH,
    amount: 3000,
    title: "Temple Entrance Fees",
    payment_date: Date.new(2025, 7, 11),
    advance_payments_attributes: [
      { participant_id: pB.id },
      { participant_id: pC.id },
      { participant_id: pD.id },
      { participant_id: pE.id },
      { participant_id: pG.id }
    ]
  )
  ExpenseAmountDistributor.new(get_expense_by_pH).call





 # full_length_check用ファイル
  load Rails.root.join("db/seeds/full_length_check.rb")








































































  rescue ActiveRecord::RecordInvalid => e
  puts "バリデーションエラー: #{e.record.errors.full_messages.join(', ')}"
  raise e
end


  # --------------------------------------------------------------------------