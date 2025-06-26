
userA = User.find_by(email: "example@email.com")

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


    trip2 = userA.trips.create!(
    title: "北海道ニセコスキー",
    departure_date: Date.new(2024, 1, 5),
    participants_attributes: [
      { name: "ゆうじ" },
      { name: "ともき" },
      { name: "はると" },
      { name: "さくら" },
      { name: "りな" },
      { name: "なおこ" },
      { name: "ひろし" },
      { name: "だいち" }
    ]
  )
  pA, pB, pC, pD, pE, pF, pG, pH = trip2.participants.order(:id)

  # --------------expenseデータNo.2-1
  get_expense_by_pA = trip2.expenses.create!(
    payer: pA,
    amount: 4340,
    title: "札幌ラーメン昼食代",
    payment_date: Date.new(2024, 1, 5),
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
    title: "お土産購入代",
    payment_date: Date.new(2024, 1, 7),
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
    amount: 2100,
    title: "登別温泉入湯税",
    payment_date: Date.new(2024, 1, 8),
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
    amount: 9640,
    title: "夜市での食べ歩き代",
    payment_date: Date.new(2024, 1, 4),
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
    amount: 10210,
    title: "海鮮丼代",
    payment_date: Date.new(2024, 1, 8),
    advance_payments_attributes: [
      { participant_id: pB.id },
      { participant_id: pD.id }
    ]
  )
  ExpenseAmountDistributor.new(get_expense_by_pB).call
  # --------------expenseデータNo.2-6
  get_expense_by_pC = trip2.expenses.create!(
    payer:pC,
    amount: 26670,
    title: "スノーブーツレンタル代",
    payment_date: Date.new(2024, 1, 6),
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
    title: "民宿代(夕食オプション付)",
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
    amount: 17000,
    title: "湖サウナ体験費",
    payment_date: Date.new(2024, 1, 7),
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
    title: "ガソリン代",
    payment_date: Date.new(2024, 1, 8),
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
    amount: 2100,
    title: "札幌駅 ロッカー",
    payment_date: Date.new(2024, 1, 7),
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
    amount: 4200,
    title: "ゆうじwifiレンタル立替",
    payment_date: Date.new(2024, 1, 6),
    advance_payments_attributes: [
      { participant_id: pA.id },
    ]
  )
  ExpenseAmountDistributor.new(get_expense_by_pE2).call
  # --------------expenseデータNo.2-12
  get_expense_by_pH = trip2.expenses.create!(
    payer: pH,
    amount: 1460,
    title: "洞爺湖遊覧船チケット",
    payment_date: Date.new(2024, 1, 8),
    advance_payments_attributes: [
      { participant_id: pB.id },
      { participant_id: pC.id },
      { participant_id: pD.id },
      { participant_id: pE.id },
      { participant_id: pG.id }
    ]
  )
  ExpenseAmountDistributor.new(get_expense_by_pH).call
