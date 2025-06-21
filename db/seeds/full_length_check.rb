user = User.find_by!(email: "example@email.com")

# group.name25字
group_max = user.groups.create!(
  name: "無計画トラベル隊日本高校四百六十期卒業生同窓会"
)

# member15字以内
# memberデータ =============================================
member_maxA = group_max.members.create!(name: "宇宙航空研究開発機構のメンバー")
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
  title: "十四回目の北海道旅行と初めての青森県りんご狩り旅行",
  departure_date: Date.new(2025, 2, 4),
  participants_attributes: [
    { name: "宇宙航空研究開発機構のメンバー" },
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
  amount: 999999,
  title: "ライブイベント費用として会場費と飲食代金を立替する",
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
  amount: 110000,
  title: "立替結果のための調整",
  payment_date: Date.today,
  place: "東京都, 東京市",
  advance_payments_attributes: [
    { participant_id: p_maxA.id }
  ]
)
ExpenseAmountDistributor.new(get_expense_by_p_maxB).call
# //////////////////////////////////////////////////////////////////////////////
