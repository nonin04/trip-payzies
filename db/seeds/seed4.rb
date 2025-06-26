userA = User.find_by(email: "example@email.com")

trip4 = userA.trips.create!(
  title: "ヨーロッパ卒業旅行",
  departure_date: Date.new(2024, 3, 1),
  participants_attributes: [
    { name: "たかし" },
    { name: "しゅん" },
    { name: "けんと" },
    { name: "りょう" },
    { name: "だいち" },
    { name: "こうた" },
    { name: "ゆうや" },
    { name: "まさと" }
  ]
)
p1, p2, p3, p4, p5, p6, p7, p8 = trip4.participants.order(:id)

# expense4-1
e1 = trip4.expenses.create!(
  payer: p1,
  amount: 49800,
  title: "ユーレイルパス購入代",
  payment_date: Date.new(2024, 3, 1),
  advance_payments_attributes: trip4.participants.map { |p| { participant_id: p.id } }
)
ExpenseAmountDistributor.new(e1).call

# expense4-2
e2 = trip4.expenses.create!(
  payer: p2,
  amount: 32500,
  title: "パリ市内観光バス代",
  payment_date: Date.new(2024, 3, 2),
  advance_payments_attributes: [
    { participant_id: p1.id },
    { participant_id: p2.id },
    { participant_id: p4.id },
    { participant_id: p5.id },
    { participant_id: p8.id }
  ]
)
ExpenseAmountDistributor.new(e2).call

# expense4-3
e3 = trip4.expenses.create!(
  payer: p3,
  amount: 21500,
  title: "アムステルダム運河クルーズ",
  payment_date: Date.new(2024, 3, 4),
  advance_payments_attributes: [
    { participant_id: p3.id },
    { participant_id: p5.id },
    { participant_id: p6.id },
    { participant_id: p7.id }
  ]
)
ExpenseAmountDistributor.new(e3).call

# expense4-4
e4 = trip4.expenses.create!(
  payer: p5,
  amount: 33000,
  title: "Airbnb宿泊費（ロンドン）",
  payment_date: Date.new(2024, 3, 5),
  advance_payments_attributes: trip4.participants.map { |p| { participant_id: p.id } }
)
ExpenseAmountDistributor.new(e4).call

# expense4-5
e5 = trip4.expenses.create!(
  payer: p4,
  amount: 5800,
  title: "ベルリンでのクラブ入場料",
  payment_date: Date.new(2024, 3, 6),
  advance_payments_attributes: [
    { participant_id: p2.id },
    { participant_id: p3.id },
    { participant_id: p4.id },
    { participant_id: p6.id },
    { participant_id: p7.id }
  ]
)
ExpenseAmountDistributor.new(e5).call

# expense4-6
e6 = trip4.expenses.create!(
  payer: p6,
  amount: 14300,
  title: "夜のビール&つまみ代",
  payment_date: Date.new(2024, 3, 4),
  advance_payments_attributes: [
    { participant_id: p1.id },
    { participant_id: p6.id },
    { participant_id: p7.id },
    { participant_id: p8.id }
  ]
)
ExpenseAmountDistributor.new(e6).call

# expense4-7
e7 = trip4.expenses.create!(
  payer: p7,
  amount: 20800,
  title: "バルセロナFC観戦チケット",
  payment_date: Date.new(2024, 3, 7),
  advance_payments_attributes: [
    { participant_id: p3.id },
    { participant_id: p4.id },
    { participant_id: p6.id },
    { participant_id: p7.id }
  ]
)
ExpenseAmountDistributor.new(e7).call

# expense4-8
e8 = trip4.expenses.create!(
  payer: p8,
  amount: 4800,
  title: "トラム1日券（ウィーン）",
  payment_date: Date.new(2024, 3, 9),
  advance_payments_attributes: [
    { participant_id: p1.id },
    { participant_id: p2.id },
    { participant_id: p3.id },
    { participant_id: p8.id }
  ]
)
ExpenseAmountDistributor.new(e8).call

# expense4-9
e9 = trip4.expenses.create!(
  payer: p5,
  amount: 15400,
  title: "ドイツビール工場見学代",
  payment_date: Date.new(2024, 3, 6),
  advance_payments_attributes: [
    { participant_id: p5.id },
    { participant_id: p6.id },
    { participant_id: p7.id }
  ]
)
ExpenseAmountDistributor.new(e9).call

# expense4-10
e10 = trip4.expenses.create!(
  payer: p6,
  amount: 20600,
  title: "ローマのピザ大食い大会",
  payment_date: Date.new(2024, 3, 8),
  advance_payments_attributes: [
    { participant_id: p1.id },
    { participant_id: p2.id },
    { participant_id: p3.id },
    { participant_id: p6.id }
  ]
)
ExpenseAmountDistributor.new(e10).call

# expense4-11
e11 = trip4.expenses.create!(
  payer: p1,
  amount: 7500,
  title: "地下鉄プリペイドカード代",
  payment_date: Date.new(2024, 3, 3),
  advance_payments_attributes: [
    { participant_id: p1.id },
    { participant_id: p4.id },
    { participant_id: p5.id }
  ]
)
ExpenseAmountDistributor.new(e11).call
