# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Expense.destroy_all
AdvancePayment.destroy_all
Participant.destroy_all
Trip.destroy_all
Group.destroy_all
User.destroy_all

#=================================================================================

# ユーザー追加--------------------------------------
user = User.create!(
  name: "test_user", 
  email: "test@example.com", 
  password: "password"
)

# グループ追加--------------------------------------
groupA = user.groups.create!(
  name: "大学ゼミ友達"
)

groupB = user.groups.create!(
  name: "高校仲良し3人組"
)

# tripデータNo.1 =============================================
tripA = user.trips.create!(
  group: groupA,
  title: "テスト旅行",
  departure_date: Date.today
)
personA = tripA.participants.create!(name: "jonh")
personB = tripA.participants.create!(name: "nonin_01")
personC = tripA.participants.create!(name: "たかし")
personD = tripA.participants.create!(name: "ゆうすけ")
personE = tripA.participants.create!(name: "しずか")
personF = tripA.participants.create!(name: "つばさ")
personG = tripA.participants.create!(name: "torrens")

          # --------------expenseデータNo.1
get_expense_by_personA = tripA.expenses.create!(
  payer: personA,
  amount: 5000,
  title: "ガソリン代",
  payment_date: Date.today
)
get_expense_by_personA.advance_payments.create!(participant: personA)
get_expense_by_personA.advance_payments.create!(participant: personB)

          # --------------expenseデータNo.2
get_expense_by_personB = tripA.expenses.create!(
  payer: personB,
  amount: 720,
  title: "おやつ代",
  payment_date: Date.today
)
get_expense_by_personB.advance_payments.create!(participant: personB)
get_expense_by_personB.advance_payments.create!(participant: personC)
get_expense_by_personB.advance_payments.create!(participant: personE)

          # --------------expenseデータNo.3
get_expense_by_personC = tripA.expenses.create!(
  payer: personC,
  amount: 200,
  title: "駐車料金",
  payment_date: Date.today
)
get_expense_by_personC.advance_payments.create!(participant: personE)
get_expense_by_personC.advance_payments.create!(participant: personF)
get_expense_by_personC.advance_payments.create!(participant: personG)

          # --------------expenseデータNo.4
get_expense_by_personD = tripA.expenses.create!(
  payer: personD,
  amount: 596540,
  title: "ホテル代2日目",
  payment_date: Date.today
)
get_expense_by_personD.advance_payments.create!(participant: personA)
get_expense_by_personD.advance_payments.create!(participant: personB)
get_expense_by_personD.advance_payments.create!(participant: personC)
get_expense_by_personD.advance_payments.create!(participant: personD)
get_expense_by_personD.advance_payments.create!(participant: personE)
get_expense_by_personD.advance_payments.create!(participant: personF)
get_expense_by_personD.advance_payments.create!(participant: personG)

          # --------------expenseデータNo.5
get_expense_by_personE = tripA.expenses.create!(
  payer: personE,
  amount: 4200,
  title: "動物園入園料",
  payment_date: Date.today
)
get_expense_by_personE.advance_payments.create!(participant: personA)
get_expense_by_personE.advance_payments.create!(participant: personG)

          # --------------expenseデータNo.6
get_expense_by_personA = tripA.expenses.create!(
  payer: personA,
  amount: 300,
  title: "朝食代[コンビニ]",
  payment_date: Date.today
)
get_expense_by_personA.advance_payments.create!(participant: personA)
get_expense_by_personA.advance_payments.create!(participant: personG)

          # --------------expenseデータNo.7
get_expense_by_personB = tripA.expenses.create!(
  payer: personB,
  amount: 3600,
  title: "昼食ハンバーガー",
  payment_date: Date.today
)
get_expense_by_personB.advance_payments.create!(participant: personB)
get_expense_by_personB.advance_payments.create!(participant: personC)
get_expense_by_personB.advance_payments.create!(participant: personF)

          # --------------expenseデータNo.7
get_expense_by_personC = tripA.expenses.create!(
  payer: personC,
  amount: 7240,
  title: "コンビニおにぎり大量買",
  payment_date: Date.today
)
get_expense_by_personC.advance_payments.create!(participant: personB)
get_expense_by_personC.advance_payments.create!(participant: personC)
get_expense_by_personC.advance_payments.create!(participant: personF)

          # --------------expenseデータNo.7
get_expense_by_personF = tripA.expenses.create!(
  payer: personF,
  amount: 600,
  title: "駐車場代(in札幌)",
  payment_date: Date.today
)
get_expense_by_personF.advance_payments.create!(participant: personB)
get_expense_by_personF.advance_payments.create!(participant: personC)
get_expense_by_personF.advance_payments.create!(participant: personF)

Rails.logger.info "Loading db/seeds/full_length_check.rb......"
load Rails.root.join('db/seeds/full_length_check.rb')

Rails.logger.info "Loading db/seeds/second_user.rb......"
load Rails.root.join('db/seeds/second_user.rb')









tripB = user.trips.create!(
  title: "東北旅",
  departure_date: Date.today)

tripC = user.trips.create!(
  title: "日帰り温泉旅",
  departure_date: Date.today)

tripD = user.trips.create!(
  title: "卒業旅行inヨーロッパ",
  departure_date: Date.today)

tripE = user.trips.create!(
  title: "大阪同期タコパ会",
  departure_date: Date.today)

tripF = user.trips.create!(
  title: "5月ユニバ",
  departure_date: Date.today)

tripG = user.trips.create!(
  title: "新潟-長岡花火大会",
  departure_date: Date.today)

tripH = user.trips.create!(
  title: "安高ゼミフィールドワーク淡路島",
  departure_date: Date.today)







userB = User.create!(
  name: "test_user3", 
  email: "test3@example.com", 
  password: "password"
)