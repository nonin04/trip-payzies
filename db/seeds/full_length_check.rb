user = User.find_by!(email: "example@email.com")

# group.name25字
group_max = user.groups.create!(
  name: "これはグループ名の表示確認用のテストケースです"
)

# member15字以内
# memberデータ =============================================
member_maxA = group_max.members.create!(name: "＃これは表示確認用テストケース")
member_maxB = group_max.members.create!(name: "はやぶさ")
member_maxC = group_max.members.create!(name: "こうのとり")
member_maxD = group_max.members.create!(name: "かぐや")
member_maxE = group_max.members.create!(name: "さきがけ")
member_maxF = group_max.members.create!(name: "ひてん")
member_maxG = group_max.members.create!(name: "すいせい")
member_maxH = group_max.members.create!(name: "のぞみ")
member_maxI = group_max.members.create!(name: "はごろも")
member_maxJ = group_max.members.create!(name: "きく")


# tripデータ =============================================
# trip.title25字
trip_max = user.trips.create!(
  group: group_max,
  title: "＃これは旅行タイトルの表示確認用のテストケースです",
  departure_date: Date.new(2021, 2, 4),
  participants_attributes: [
    { name: "＃これは表示確認用テストケース" },
    { name: "はやぶさ" },
    { name: "こうのとり" },
    { name: "かぐや" },
    { name: "さきがけ" },
    { name: "ひてん" },
    { name: "すいせい" },
    { name: "のぞみ" },
    { name: "はごろも" },
    { name: "きく" }
  ]
)

p_maxA, p_maxB, p_maxC, p_maxD, p_maxE, p_maxF, p_maxG, p_maxH, p_maxI, p_maxJ = trip_max.participants.order(:id)

# --------------expenseデータ
# expense.title25字
# expense.amount1000000以下

# --------------max_expenseデータNo.1
get_expense_by_p_maxA = trip_max.expenses.create!(
  payer: p_maxA,
  amount_local: 999999,
  title: "＃これは立替タイトルの表示確認用のテストケースです",
  payment_date: Date.today,
  place: "東京都, 東京市",
  advance_payments_attributes: [
    { participant_id: p_maxB.id },
    { participant_id: p_maxC.id },
    { participant_id: p_maxD.id },
    { participant_id: p_maxE.id },
    { participant_id: p_maxF.id },
    { participant_id: p_maxG.id },
    { participant_id: p_maxH.id },
    { participant_id: p_maxI.id },
    { participant_id: p_maxJ.id }
  ]
)
ExpenseAmountDistributor.new(get_expense_by_p_maxA).call
# --------------max_expenseデータNo.2
get_expense_by_p_maxB = trip_max.expenses.create!(
  payer: p_maxB,
  amount_local: 110000,
  title: "立替結果調整用",
  payment_date: Date.today,
  place: "東京都, 東京市",
  advance_payments_attributes: [
    { participant_id: p_maxA.id }
  ]
)
ExpenseAmountDistributor.new(get_expense_by_p_maxB).call
# //////////////////////////////////////////////////////////////////////////////
