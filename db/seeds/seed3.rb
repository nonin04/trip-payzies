userA = User.find_by(email: "example@email.com")

trip3 = userA.trips.create!(
  title: "沖縄離島めぐり旅",
  departure_date: Date.new(2024, 9, 10),
  participants_attributes: [
    { name: "あきら" },
    { name: "みさき" },
    { name: "けんと" },
    { name: "ゆうこ" },
    { name: "はるな" },
    { name: "りく" },
    { name: "まこと" },
    { name: "さえ" }
  ]
)
p1, p2, p3, p4, p5, p6, p7, p8 = trip3.participants.order(:id)

# expense3-1
e1 = trip3.expenses.create!(
  payer: p1,
  amount: 36800,
  title: "那覇〜石垣フェリー代",
  payment_date: Date.new(2024, 9, 10),
  advance_payments_attributes: trip3.participants.map { |p| { participant_id: p.id } }
)
ExpenseAmountDistributor.new(e1).call

# expense3-2
e2 = trip3.expenses.create!(
  payer: p3,
  amount: 12600,
  title: "石垣島レンタカー代",
  payment_date: Date.new(2024, 9, 11),
  advance_payments_attributes: [
    { participant_id: p1.id },
    { participant_id: p3.id },
    { participant_id: p4.id },
    { participant_id: p5.id },
    { participant_id: p7.id }
  ]
)
ExpenseAmountDistributor.new(e2).call

# expense3-3
e3 = trip3.expenses.create!(
  payer: p6,
  amount: 8400,
  title: "川平湾グラスボート体験",
  payment_date: Date.new(2024, 9, 11),
  advance_payments_attributes: [
    { participant_id: p2.id },
    { participant_id: p5.id },
    { participant_id: p6.id },
    { participant_id: p8.id }
  ]
)
ExpenseAmountDistributor.new(e3).call

# expense3-4
e4 = trip3.expenses.create!(
  payer: p2,
  amount: 29600,
  title: "宿泊費（竹富島民宿）",
  payment_date: Date.new(2024, 9, 11),
  advance_payments_attributes: trip3.participants.map { |p| { participant_id: p.id } }
)
ExpenseAmountDistributor.new(e4).call

# expense3-5
e5 = trip3.expenses.create!(
  payer: p4,
  amount: 5500,
  title: "竹富島レンタサイクル代",
  payment_date: Date.new(2024, 9, 12),
  advance_payments_attributes: [
    { participant_id: p1.id },
    { participant_id: p3.id },
    { participant_id: p4.id },
    { participant_id: p6.id }
  ]
)
ExpenseAmountDistributor.new(e5).call

# expense3-6
e6 = trip3.expenses.create!(
  payer: p5,
  amount: 11800,
  title: "石垣牛焼肉ディナー",
  payment_date: Date.new(2024, 9, 12),
  advance_payments_attributes: [
    { participant_id: p2.id },
    { participant_id: p5.id },
    { participant_id: p6.id },
    { participant_id: p8.id }
  ]
)
ExpenseAmountDistributor.new(e6).call

# expense3-7
e7 = trip3.expenses.create!(
  payer: p7,
  amount: 4600,
  title: "お土産（泡盛・ちんすこう）",
  payment_date: Date.new(2024, 9, 13),
  advance_payments_attributes: [
    { participant_id: p3.id },
    { participant_id: p4.id },
    { participant_id: p7.id }
  ]
)
ExpenseAmountDistributor.new(e7).call

# expense3-8
e8 = trip3.expenses.create!(
  payer: p6,
  amount: 2050,
  title: "西表島フェリー港ロッカー",
  payment_date: Date.new(2024, 9, 13),
  advance_payments_attributes: [
    { participant_id: p6.id },
    { participant_id: p8.id }
  ]
)
ExpenseAmountDistributor.new(e8).call

# expense3-9
e9 = trip3.expenses.create!(
  payer: p8,
  amount: 3360,
  title: "カフェ代（離島ターミナル）",
  payment_date: Date.new(2024, 9, 13),
  advance_payments_attributes: [
    { participant_id: p1.id },
    { participant_id: p2.id },
    { participant_id: p8.id }
  ]
)
ExpenseAmountDistributor.new(e9).call

# expense3-10
e10 = trip3.expenses.create!(
  payer: p1,
  amount: 4980,
  title: "ドリンク＆軽食まとめ買い",
  payment_date: Date.new(2024, 9, 10),
  advance_payments_attributes: [
    { participant_id: p1.id },
    { participant_id: p2.id },
    { participant_id: p3.id },
    { participant_id: p4.id }
  ]
)
ExpenseAmountDistributor.new(e10).call

# expense3-11
e11 = trip3.expenses.create!(
  payer: p3,
  amount: 9600,
  title: "ガソリン代（石垣島）",
  payment_date: Date.new(2024, 9, 12),
  advance_payments_attributes: trip3.participants.map { |p| { participant_id: p.id } }
)
ExpenseAmountDistributor.new(e11).call
