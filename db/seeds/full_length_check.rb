user = User.find_by!(email: "test@example.com")

#group.name20字
group_max = user.groups.create!(
  name: "無計画トラベル隊日本高校四百六十期卒業生"
)

##member15字以内
#memberデータ =============================================
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
#trip.title20字
trip_max = user.trips.create!(
  group: group_max,
  title: "十一回目の北海道旅行と初めての青森県旅行",
  departure_date: Date.new(2025, 2, 4)
)
#participant.name15文字 最大参加者数10
person_maxA = trip_max.participants.create!(name: "宇宙航空研究開発機構のメンバー")
person_maxB = trip_max.participants.create!(name: "はやぶさ")
person_maxC = trip_max.participants.create!(name: "こうのとり")
person_maxD = trip_max.participants.create!(name: "かぐや")
person_maxE = trip_max.participants.create!(name: "さきがけ")
person_maxF = trip_max.participants.create!(name: "ひてん")
person_maxG = trip_max.participants.create!(name: "すいせい")
person_maxH = trip_max.participants.create!(name: "のぞみ")
person_maxI = trip_max.participants.create!(name: "はごろも")
person_maxJ = trip_max.participants.create!(name: "きく")


# --------------expenseデータ
#expense.title20字
#expense.amount1000000以下
expense_max = trip_max.expenses.create!(
  payer: person_maxA,
  title: "ライブイベント費用として会場費と飲食代金",
  amount: 999999,
  payment_date: Date.today
)

expense_max.advance_payments.create!(participant: person_maxA)
expense_max.advance_payments.create!(participant: person_maxB)
expense_max.advance_payments.create!(participant: person_maxE)
expense_max.advance_payments.create!(participant: person_maxG)
expense_max.advance_payments.create!(participant: person_maxH)
expense_max.advance_payments.create!(participant: person_maxJ)
# //////////////////////////////////////////////////////////////////////////////

