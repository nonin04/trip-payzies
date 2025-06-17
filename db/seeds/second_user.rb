# //////////////////////////////////////////////////////////////////////////////
userB = User.create!(
  name: "test_user2",
  email: "test2@example.com",
  password: "password"
)
# tripデータNo.1 =============================================
trip1 = userB.trips.create!(
  title: "テスト旅行",
  departure_date: Date.today
)
person1A = trip1.participants.create!(name: "参加者1A")
person1B = trip1.participants.create!(name: "参加者1B")
person1C = trip1.participants.create!(name: "参加者1C")

# --------------expenseデータNo.1
get_expense_by_person1A = trip1.expenses.create!(
  payer: person1A,
  amount: 5000,
  title: "ガソリン代",
  payment_date: Date.today
)
get_expense_by_person1A.advance_payments.create!(participant: person1A)
get_expense_by_person1A.advance_payments.create!(participant: person1B)

# --------------expenseデータNo.2
get_expense_by_person1B = trip1.expenses.create!(
  payer: person1B,
  amount: 5000,
  title: "ガソリン代",
  payment_date: Date.today
)
get_expense_by_person1B.advance_payments.create!(participant: person1A)
get_expense_by_person1B.advance_payments.create!(participant: person1C)

# --------------expenseデータNo.3
get_expense_by_person1B = trip1.expenses.create!(
  payer: person1B,
  amount: 5000,
  title: "旅館宿泊代[登別温泉:石水亭]",
  payment_date: Date.today
)
get_expense_by_person1B.advance_payments.create!(participant: person1A)
get_expense_by_person1B.advance_payments.create!(participant: person1C)

# --------------expenseデータNo.4
get_expense_by_person1B = trip1.expenses.create!(
  payer: person1B,
  amount: 1200,
  title: "観光地入場チケット4人分まとめて",
  payment_date: Date.today
)
get_expense_by_person1B.advance_payments.create!(participant: person1A)
get_expense_by_person1B.advance_payments.create!(participant: person1C)

# --------------expenseデータNo.5
get_expense_by_person1B = trip1.expenses.create!(
  payer: person1C,
  amount: 340,
  title: "道の駅で買った地元野菜",
  payment_date: Date.today
)
get_expense_by_person1B.advance_payments.create!(participant: person1A)
get_expense_by_person1B.advance_payments.create!(participant: person1C)





# tripデータNo.2 =============================================
trip2 = userB.trips.create!(
  title: "テスト旅行2",
  departure_date: Date.new(2025, 2, 4)
)
person2A = trip2.participants.create!(name: "参加者2A")
person2B = trip2.participants.create!(name: "参加者2B")
person2C = trip2.participants.create!(name: "参加者2C")

# --------------expenseデータNo.1
get_expense_by_person2A = trip2.expenses.create!(
  payer: person2A,
  amount: 5000,
  title: "ガソリン代",
  payment_date: Date.today
)
get_expense_by_person2A.advance_payments.create!(participant: person2A)
get_expense_by_person2A.advance_payments.create!(participant: person2B)

# --------------expenseデータNo.2
get_expense_by_person2B = trip2.expenses.create!(
  payer: person2B,
  amount: 5000,
  title: "ガソリン代",
  payment_date: Date.today
)
get_expense_by_person2B.advance_payments.create!(participant: person2A)
get_expense_by_person2B.advance_payments.create!(participant: person2C)

# //////////////////////////////////////////////////////////////////////////////
