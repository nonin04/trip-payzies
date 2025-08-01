#デモアカウント初期化
user = User.find_by(email: "demo@email.com")
if user
  user.groups.destroy_all
  user.trips.destroy_all
  user.destroy
end
#------------------------------------------
user = User.create!(
  name: "demo_user",
  email: "demo@email.com",
  password: "password",
  role: :demo
  )
#------------------------------------------
jpy = Currency.find_by(code: "JPY")
usd = Currency.find_by(code: "USD")
eur = Currency.find_by(code: "EUR")
krw = Currency.find_by(code: "KRW")
gbp = Currency.find_by(code: "GBP")
thb = Currency.find_by(code: "THB")
#------------------------------------------



# -----------------------------------------------------------------------------------------------
# グループ1：中学バスケ部
g1 = user.groups.create!(
  name: "中学バスケ部",
  icon: File.open(Rails.root.join("public/images/demo/basketball.png"))
)
%w[こうた れい しゅうと たかひろ だいご けんしん まさと あやか ちなつ].each do |name|
  g1.members.create!(name: name)
end

# グループ2：旅行好き社会人
g2 = user.groups.create!(
  name: "旅行好き社会人",
  icon: File.open(Rails.root.join("public/images/demo/travel.png"))
)
%w[はるか しょう かなこ りゅうた めい ひでと なおき えりか].each do |name|
  g2.members.create!(name: name)
end

# グループ3：大学キャンプサークル
g3 = user.groups.create!(
  name: "大学キャンプサークル",
  icon: File.open(Rails.root.join("public/images/demo/camp.png"))
)
%w[ゆうと まい けいた たかし].each do |name|
  g3.members.create!(name: name)
end

# グループ4：フットサル仲間
g4 = user.groups.create!(
  name: "フットサル仲間",
  icon: File.open(Rails.root.join("public/images/demo/football.png"))
)
%w[りょう たける なおと かずま ゆり せな].each do |name|
  g4.members.create!(name: name)
end

# グループ5：卒業旅行メンバー
g5 = user.groups.create!(
  name: "卒業旅行メンバー",
  icon: File.open(Rails.root.join("public/images/demo/graduate.png"))
)
%w[みさ りくや なお ふうか はるき あやね ひなた りょうへい].each do |name|
  g5.members.create!(name: name)
end

# グループ6：社会人登山クラブ
g6 = user.groups.create!(
  name: "社会人登山クラブ",
  icon: File.open(Rails.root.join("public/images/demo/mountain.png"))
)
%w[しょうた ゆうな かずき みお てつや さき けんじ まこ].each do |name|
  g6.members.create!(name: name)
end

# グループ7：ダンスイベント仲間
g7 = user.groups.create!(
  name: "ダンスイベント仲間",
  icon: File.open(Rails.root.join("public/images/demo/dance.png"))
)
%w[ゆりな たくみ なおや しおん かな けいすけ まいこ ひろむ ことね れん].each do |name|
  g7.members.create!(name: name)
end

# グループ8：大学ゼミ友達
g8 = user.groups.create!(
  name: "大学ゼミ",
  icon: File.open(Rails.root.join("public/images/demo/semi.png"))
)
%w[さとし みゆき ひろき えみ].each do |name|
  g8.members.create!(name: name)
end

# グループ9：幼なじみ
g9 = user.groups.create!(name: "幼なじみ")
%w[あおい はると ゆづき そうた ゆいな].each do |name|
  g9.members.create!(name: name)
end

# グループ10：海外旅行チーム
g10 = user.groups.create!(
  name: "海外旅行チーム",
icon: File.open(Rails.root.join("public/images/demo/foreign.png"))
)
%w[ゆうま まなみ しんご けいこ だいすけ りかこ そう みな けい つばさ].each do |name|
  g10.members.create!(name: name)
end

# -----------------------------------------------------------------------------------------------
# settlement_statusは{ unsettled: 0, settled: 1 }





#------------------------------------------
trip = user.trips.create!(group: g1, currency: jpy, title: "北海道ニセコスキー", departure_date: Date.new(2024, 1, 5), settlement_status: 1,
  participants_attributes: [
    { name: "ゆうじ" }, { name: "ともき" }, { name: "はると" }, { name: "さくら" },
    { name: "りな" }, { name: "なおこ" }, { name: "ひろし" }, { name: "だいち" }
  ]
)

p = trip.participants.order(:id)
expenses_data = [
  { payer: p[0], amount_local: 4340, currency: jpy,  title: "札幌ラーメン昼食代", payment_date: Date.new(2024, 1, 5),  participant_ids: [ p[2].id, p[4].id, p[5].id, p[6].id, p[7].id ] },
  { payer: p[5], amount_local: 28630, currency: jpy, title: "お土産購入代", payment_date: Date.new(2024, 1, 7),  participant_ids: p.map(&:id) },
  { payer: p[6], amount_local: 2100, currency: jpy,  title: "登別温泉入湯税", payment_date: Date.new(2024, 1, 8),  participant_ids: [ p[0].id, p[1].id, p[2].id, p[3].id, p[4].id, p[5].id, p[7].id ] },
  { payer: p[4], amount_local: 9640, currency: jpy,  title: "夜市での食べ歩き代", payment_date: Date.new(2024, 1, 4),  participant_ids: [ p[0].id, p[5].id, p[6].id, p[7].id ] },
  { payer: p[1], amount_local: 10213, currency: jpy, title: "海鮮丼代", payment_date: Date.new(2024, 1, 8),  participant_ids: [ p[1].id, p[3].id ] },
  { payer: p[2], amount_local: 26670, currency: jpy, title: "スノーブーツレンタル代", payment_date: Date.new(2024, 1, 6),  participant_ids: [ p[1].id, p[2].id, p[3].id, p[4].id, p[5].id, p[6].id, p[7].id ] },
  { payer: p[5], amount_local: 73500, currency: jpy, title: "民宿代(夕食オプション付)", payment_date: Date.new(2025, 7, 6),  participant_ids: p.map(&:id) },
  { payer: p[1], amount_local: 17000, currency: jpy, title: "湖サウナ体験費", payment_date: Date.new(2024, 1, 7),  participant_ids: [ p[3].id, p[4].id ] },
  { payer: p[2], amount_local: 4854, currency: jpy,  title: "ガソリン代", payment_date: Date.new(2024, 1, 8),  participant_ids: p.map(&:id) },
  { payer: p[6], amount_local: 2100, currency: jpy,  title: "札幌駅 ロッカー", payment_date: Date.new(2024, 1, 7),  participant_ids: [ p[4].id, p[5].id, p[7].id ] },
  { payer: p[7], amount_local: 1460, currency: jpy,  title: "洞爺湖遊覧船チケット", payment_date: Date.new(2024, 1, 8),  participant_ids: [ p[1].id, p[2].id, p[3].id, p[4].id, p[6].id ] }
]
expenses_data.each do |data|
  expense = trip.expenses.create!(
    payer: data[:payer],
    amount_local: data[:amount_local],
    currency: data[:currency],
    title: data[:title],
    payment_date: data[:payment_date],
    advance_payments_attributes: data[:participant_ids].map { |id| { participant_id: id } }
  )
  ExpenseAmountDistributor.new(expense).call
end
#-----------------------------------------


#-----------------------------------------
trip = user.trips.create!(group: g8, currency: eur, title: "ヨーロッパ卒業旅行", departure_date: Date.new(2025, 7, 20), settlement_status: 0,
  participants_attributes: [
    { name: "さとし" }, { name: "みゆき" }, { name: "ひろき" }, { name: "えみ" }
  ]
)
#-----------------------------------------
p = trip.participants.order(:id)
expenses_data = [
  { payer: p[0], amount_local: 45.80, currency: eur, title: "パリ地下鉄回数券", payment_date: Date.new(2025, 7, 20), participant_ids: [p[0].id, p[1].id, p[2].id, p[3].id] },
  { payer: p[1], amount_local: 123.50, currency: eur, title: "ルーブル美術館 入場料", payment_date: Date.new(2025, 7, 21), participant_ids: [p[0].id, p[1].id] },
  { payer: p[2], amount_local: 3200, currency: jpy, title: "市内〜空港バス代", payment_date: Date.new(2025, 7, 20), participant_ids: [p[0].id, p[1].id, p[2].id, p[3].id] },
  { payer: p[3], amount_local: 58.00, currency: eur, title: "エッフェル塔チケット", payment_date: Date.new(2025, 7, 23), participant_ids: [p[0].id, p[3].id] },
  { payer: p[0], amount_local: 89.90, currency: eur, title: "イタリア国鉄移動費", payment_date: Date.new(2025, 7, 21), participant_ids: [p[1].id, p[2].id, p[3].id] },
  { payer: p[1], amount_local: 27000, currency: jpy, title: "Wi-Fiルーター レンタル代", payment_date: Date.new(2025, 7, 20), participant_ids: [p[0].id, p[1].id, p[2].id, p[3].id] },
  { payer: p[2], amount_local: 76.40, currency: eur, title: "ミラノ大聖堂 入場料金", payment_date: Date.new(2025, 7, 21), participant_ids: [p[2].id, p[3].id] },
  { payer: p[3], amount_local: 129.99, currency: eur, title: "宿泊費（パリ）", payment_date: Date.new(2025, 7, 23), participant_ids: [p[0].id, p[1].id, p[2].id, p[3].id] },
  { payer: p[0], amount_local: 18.50, currency: eur, title: "ジェラート代（トレビの泉近く）", payment_date: Date.new(2025, 7, 22), participant_ids: [p[1].id, p[2].id, p[3].id] },
  { payer: p[1], amount_local: 42.75, currency: eur, title: "空港シャトル（ローマ→フィウミチーノ）", payment_date: Date.new(2025, 7, 24), participant_ids: [p[0].id, p[1].id, p[3].id] }
]
expenses_data.each do |data|
  expense = trip.expenses.create!(
    payer: data[:payer],
    amount_local: data[:amount_local],
    currency: data[:currency],
    title: data[:title],
    payment_date: data[:payment_date],
    advance_payments_attributes: data[:participant_ids].map { |id| { participant_id: id } }
  )
  ExpenseAmountDistributor.new(expense).call
end
#-----------------------------------------



#-----------------------------------------
trip = user.trips.create!(group: g7, currency: usd, title: "アメリカ遠征", departure_date: Date.new(2025, 7, 19), settlement_status: 0,
  participants_attributes: [
    { name: "ゆりな" }, { name: "たくみ" }, { name: "なおや" }, { name: "しおん" },
    { name: "かな" }, { name: "けいすけ" }, { name: "れん" }
  ]
)
#-----------------------------------------
p = trip.participants.order(:id)
expenses_data = [
  { payer: p[0], amount_local: 134.75, currency: usd, title: "JFK空港→マンハッタン タクシー代", payment_date: Date.new(2025, 7, 24), participant_ids: [p[0].id, p[1].id, p[2].id, p[3].id] },
  { payer: p[1], amount_local: 84.00, currency: usd, title: "地下鉄メトロカード(7日券)", payment_date: Date.new(2025, 7, 25), participant_ids: [p[1].id, p[2].id, p[3].id, p[4].id] },
  { payer: p[2], amount_local: 28000, currency: jpy, title: "海外用SIMカード購入", payment_date: Date.new(2025, 7, 23), participant_ids: [p[0].id, p[2].id, p[5].id, p[6].id] },
  { payer: p[3], amount_local: 122.50, currency: usd, title: "自由の女神フェリー＆入場料", payment_date: Date.new(2025, 7, 26), participant_ids: [p[0].id, p[3].id, p[4].id] },
  { payer: p[4], amount_local: 340.52, currency: usd, title: "ホテル代（3泊分の一部）", payment_date: Date.new(2025, 7, 27), participant_ids: [p[0].id, p[1].id, p[2].id, p[4].id, p[5].id] },
  { payer: p[5], amount_local: 98.60, currency: usd, title: "ブロードウェイ観劇チケット", payment_date: Date.new(2025, 7, 28), participant_ids: [p[5].id, p[6].id] },
  { payer: p[6], amount_local: 210.18, currency: usd, title: "セントラルパーク ピクニック食材", payment_date: Date.new(2025, 7, 28), participant_ids: [p[0].id, p[1].id, p[2].id, p[3].id, p[6].id] },
  { payer: p[0], amount_local: 65.40, currency: usd, title: "タイムズスクエアでの軽食", payment_date: Date.new(2025, 7, 27), participant_ids: [p[0].id, p[1].id, p[5].id] },
  { payer: p[1], amount_local: 132.00, currency: usd, title: "MOMA（近代美術館）入場料", payment_date: Date.new(2025, 7, 26), participant_ids: [p[1].id, p[2].id, p[3].id, p[4].id] },
  { payer: p[2], amount_local: 58.25, currency: usd, title: "アイス・コーヒー代", payment_date: Date.new(2025, 7, 29), participant_ids: [p[2].id, p[3].id, p[6].id] },
  { payer: p[4], amount_local: 275.00, currency: usd, title: "帰国前日のディナー", payment_date: Date.new(2025, 7, 31), participant_ids: [p[0].id, p[1].id, p[2].id, p[3].id, p[4].id, p[5].id] },
  { payer: p[3], amount_local: 110.00, currency: usd, title: "ホテル→空港シャトルバス代", payment_date: Date.new(2025, 7, 28), participant_ids: [p[3].id, p[4].id, p[5].id, p[6].id] },
  { payer: p[0], amount_local: 1620, currency: jpy, title: "羽田空港へのリムジンバス", payment_date: Date.new(2025, 7, 24), participant_ids: [p[0].id, p[1].id, p[2].id] },
  { payer: p[6], amount_local: 2980, currency: jpy, title: "成田空港での昼食（出発前）", payment_date: Date.new(2025, 7, 24), participant_ids: [p[4].id, p[5].id, p[6].id] }
]

expenses_data.each do |data|
  expense = trip.expenses.create!(
    payer: data[:payer],
    amount_local: data[:amount_local],
    currency: data[:currency],
    title: data[:title],
    payment_date: data[:payment_date],
    advance_payments_attributes: data[:participant_ids].map { |id| { participant_id: id } }
  )
  ExpenseAmountDistributor.new(expense).call
end
#---------------------------





#-----------------------------------------
trip = user.trips.create!(group: g10, currency: krw, title: "ソウル2泊3日", departure_date: Date.new(2025, 7, 28), settlement_status: 0,
  participants_attributes: [
    { name: "ゆうま" }, { name: "まなみ" }, { name: "しんご" }, { name: "けいご" }, { name: "だいすけ" },
    { name: "りかこ" }, { name: "そう" }, { name: "みな" }, { name: "けい" }, { name: "つばさ" }
  ]
)
#-----------------------------------------
p = trip.participants.order(:id)
expenses_data = [

  { payer: p[0], amount_local: 3400, currency: jpy, title: "成田空港までのリムジンバス", payment_date: Date.new(2025, 7, 28), participant_ids: [p[0].id, p[1].id, p[2].id, p[3].id] },
  { payer: p[3], amount_local: 12800, currency: jpy, title: "Wi-Fiレンタル代（3日分）", payment_date: Date.new(2025, 7, 28), participant_ids: [p[3].id, p[4].id, p[5].id, p[6].id] },
  { payer: p[5], amount_local: 5600, currency: jpy, title: "仁川空港での昼食", payment_date: Date.new(2025, 7, 28), participant_ids: [p[5].id, p[6].id, p[7].id] },
  { payer: p[9], amount_local: 2900, currency: jpy, title: "出発前の飲み物代", payment_date: Date.new(2025, 7, 28), participant_ids: [p[8].id, p[9].id] },
  { payer: p[1], amount_local: 87000, currency: krw, title: "地下鉄T-moneyチャージ", payment_date: Date.new(2025, 7, 28), participant_ids: [p[0].id, p[1].id, p[2].id, p[3].id, p[4].id] },
  { payer: p[2], amount_local: 132000, currency: krw, title: "ホテル代（2泊分一部）", payment_date: Date.new(2025, 7, 28), participant_ids: [p[0].id, p[2].id, p[4].id, p[6].id, p[8].id] },
  { payer: p[4], amount_local: 62000, currency: krw, title: "明洞屋台フード食べ歩き", payment_date: Date.new(2025, 7, 29), participant_ids: [p[3].id, p[4].id, p[5].id, p[6].id] },
  { payer: p[6], amount_local: 28000, currency: krw, title: "ソウルタワー入場料", payment_date: Date.new(2025, 7, 29), participant_ids: [p[6].id, p[7].id] },
  { payer: p[7], amount_local: 49000, currency: krw, title: "カフェ休憩代（弘大）", payment_date: Date.new(2025, 7, 29), participant_ids: [p[1].id, p[2].id, p[7].id, p[8].id] },
  { payer: p[8], amount_local: 91000, currency: krw, title: "韓国コスメお土産まとめ買い", payment_date: Date.new(2025, 7, 30), participant_ids: [p[0].id, p[4].id, p[8].id, p[9].id] },
  { payer: p[9], amount_local: 75000, currency: krw, title: "サムギョプサル夕食代", payment_date: Date.new(2025, 7, 30), participant_ids: [p[0].id, p[1].id, p[2].id, p[3].id, p[9].id] },
  { payer: p[0], amount_local: 36500, currency: krw, title: "空港までのKTXチケット", payment_date: Date.new(2025, 7, 30), participant_ids: [p[0].id, p[1].id, p[2].id, p[3].id] }
]

expenses_data.each do |data|
  expense = trip.expenses.create!(
    payer: data[:payer],
    amount_local: data[:amount_local],
    currency: data[:currency],
    title: data[:title],
    payment_date: data[:payment_date],
    advance_payments_attributes: data[:participant_ids].map { |id| { participant_id: id } }
  )
  ExpenseAmountDistributor.new(expense).call
end
#-----------------------------------------





#-----------------------------------------
trip = user.trips.create!(group: g6, currency: jpy, title: "春の北アルプス登山旅", departure_date: Date.new(2025, 4, 15), settlement_status: 1,
  participants_attributes: [
    { name: "しょうた" }, { name: "ゆうな" }, { name: "かずき" }, { name: "みお" },
    { name: "てつや" }, { name: "さき" }, { name: "りょう" }, { name: "けんじ" }
  ]
)
#-----------------------------------------
p = trip.participants.order(:id)
expenses_data = [
  { payer: p[0], amount_local: 4500, currency: jpy, title: "レンタカー代（2日分）", payment_date: Date.new(2025, 4, 15), participant_ids: p.map(&:id) },
  { payer: p[1], amount_local: 2343, currency: jpy, title: "昼食弁当購入", payment_date: Date.new(2025, 4, 15), participant_ids: [p[0].id, p[1].id, p[2].id, p[3].id] },
  { payer: p[2], amount_local: 1500, currency: jpy, title: "入山料", payment_date: Date.new(2025, 4, 16), participant_ids: p.map(&:id) },
  { payer: p[3], amount_local: 2850, currency: jpy, title: "山小屋宿泊費（一部）", payment_date: Date.new(2025, 4, 16), participant_ids: [p[3].id, p[4].id, p[5].id] },
  { payer: p[4], amount_local: 1200, currency: jpy, title: "登山靴レンタル代", payment_date: Date.new(2025, 4, 15), participant_ids: [p[4].id, p[5].id, p[6].id] },
  { payer: p[5], amount_local: 3500, currency: jpy, title: "温泉入浴料", payment_date: Date.new(2025, 4, 17), participant_ids: p.map(&:id) },
  { payer: p[6], amount_local: 1828, currency: jpy, title: "飲料・補給食", payment_date: Date.new(2025, 4, 15), participant_ids: [p[6].id, p[7].id] },
  { payer: p[7], amount_local: 2100, currency: jpy, title: "地元食材の夕食代", payment_date: Date.new(2025, 4, 16), participant_ids: [p[0].id, p[1].id, p[7].id] },
  { payer: p[0], amount_local: 900, currency: jpy, title: "マップ購入", payment_date: Date.new(2025, 4, 15), participant_ids: p.map(&:id) },
  { payer: p[1], amount_local: 1100, currency: jpy, title: "公共交通機関利用（バス代）", payment_date: Date.new(2025, 4, 17), participant_ids: [p[2].id, p[3].id, p[4].id, p[5].id] }
]

expenses_data.each do |data|
  expense = trip.expenses.create!(
    payer: data[:payer],
    amount_local: data[:amount_local],
    currency: data[:currency],
    title: data[:title],
    payment_date: data[:payment_date],
    advance_payments_attributes: data[:participant_ids].map { |id| { participant_id: id } }
  )
  ExpenseAmountDistributor.new(expense).call
end
#-----------------------------------------




#-----------------------------------------
trip = user.trips.create!(group: g4, currency: jpy, title: "九州絶景と温泉満喫旅", departure_date: Date.new(2025, 4, 15), settlement_status: 1,
  participants_attributes: [
    { name: "りょう" }, { name: "たける" }, { name: "なおと" }, { name: "かずま" },
    { name: "ゆり" }, { name: "せな" }
  ]
)
#-----------------------------------------
p = trip.participants.order(:id)
expenses_data = [
  { payer: p[0], amount_local: 4230, currency: jpy, title: "熊本空港〜市内バス代", payment_date: Date.new(2024, 5, 28), participant_ids: p.map(&:id) },
  { payer: p[1], amount_local: 9800, currency: jpy, title: "熊本城入場料", payment_date: Date.new(2024, 5, 29), participant_ids: [p[0].id, p[1].id, p[2].id] },
  { payer: p[2], amount_local: 5420, currency: jpy, title: "熊本ラーメン昼食代", payment_date: Date.new(2024, 5, 29), participant_ids: p.map(&:id) },
  { payer: p[3], amount_local: 25000, currency: jpy, title: "レンタカー代（3日分）", payment_date: Date.new(2024, 5, 28), participant_ids: p.map(&:id) },
  { payer: p[4], amount_local: 13500, currency: jpy, title: "霧島温泉宿泊費", payment_date: Date.new(2024, 5, 30), participant_ids: [p[2].id, p[3].id, p[4].id, p[5].id] },
  { payer: p[5], amount_local: 5300, currency: jpy, title: "指宿砂蒸し温泉入場料", payment_date: Date.new(2024, 5, 31), participant_ids: p.map(&:id) },
  { payer: p[0], amount_local: 8000, currency: jpy, title: "鹿児島黒豚料理夕食代", payment_date: Date.new(2024, 5, 30), participant_ids: [p[0].id, p[1].id, p[4].id] },
  { payer: p[1], amount_local: 4500, currency: jpy, title: "桜島フェリー代", payment_date: Date.new(2024, 5, 30), participant_ids: [p[1].id, p[2].id, p[3].id] },
  { payer: p[2], amount_local: 6000, currency: jpy, title: "別府地獄めぐり入場料", payment_date: Date.new(2024, 5, 31), participant_ids: [p[0].id, p[2].id, p[5].id] },
  { payer: p[3], amount_local: 12000, currency: jpy, title: "別府温泉宿泊費", payment_date: Date.new(2024, 5, 31), participant_ids: p.map(&:id) },
  { payer: p[4], amount_local: 3700, currency: jpy, title: "大分郷土料理夕食代", payment_date: Date.new(2024, 6, 1), participant_ids: [p[3].id, p[4].id, p[5].id] },
  { payer: p[5], amount_local: 5200, currency: jpy, title: "お土産代（熊本・鹿児島・大分）", payment_date: Date.new(2024, 6, 1), participant_ids: p.map(&:id) },
  { payer: p[0], amount_local: 3589, currency: jpy, title: "ガソリン代", payment_date: Date.new(2024, 5, 29), participant_ids: p.map(&:id) },
  { payer: p[1], amount_local: 2800, currency: jpy, title: "高速道路料金", payment_date: Date.new(2024, 5, 30), participant_ids: p.map(&:id) },
  { payer: p[2], amount_local: 4000, currency: jpy, title: "観光地入場料", payment_date: Date.new(2024, 5, 31), participant_ids: [p[0].id, p[1].id, p[2].id, p[3].id] },
  { payer: p[3], amount_local: 9559, currency: jpy, title: "旅の記念ディナー", payment_date: Date.new(2024, 6, 1), participant_ids: p.map(&:id) }
]
expenses_data.each do |data|
  expense = trip.expenses.create!(
    payer: data[:payer],
    amount_local: data[:amount_local],
    currency: data[:currency],
    title: data[:title],
    payment_date: data[:payment_date],
    advance_payments_attributes: data[:participant_ids].map { |id| { participant_id: id } }
  )
  ExpenseAmountDistributor.new(expense).call
end
#-----------------------------------------



#-----------------------------------------
trip = user.trips.create!(currency: jpy, title: "雪と郷土めしの東北旅", departure_date: Date.new(2025, 3, 14), settlement_status: 1,
  participants_attributes: [
    { name: "ゆうた" }, { name: "あいり" }, { name: "だいち" }, { name: "さやか" },
    { name: "けんじ" }, { name: "みほ" }, { name: "しんや" }, { name: "なおこ" }
  ]
)

p = trip.participants.order(:id)

expenses_data = [
  { payer: p[0], amount_local: 9200, currency: jpy, title: "仙台〜蔵王バス代", payment_date: Date.new(2025, 3, 14), participant_ids: p.map(&:id) },
  { payer: p[1], amount_local: 48000, currency: jpy, title: "スキー場リフト券まとめ買い", payment_date: Date.new(2025, 3, 15), participant_ids: p.map(&:id) },
  { payer: p[2], amount_local: 20000, currency: jpy, title: "スノボレンタル代", payment_date: Date.new(2025, 3, 15), participant_ids: [p[0].id, p[2].id, p[3].id, p[4].id] },
  { payer: p[3], amount_local: 3250, currency: jpy, title: "ゲレンデランチ", payment_date: Date.new(2025, 3, 15), participant_ids: p.map(&:id) },
  { payer: p[4], amount_local: 6400, currency: jpy, title: "温泉施設入浴料", payment_date: Date.new(2025, 3, 16), participant_ids: [p[1].id, p[2].id, p[3].id, p[4].id, p[5].id] },
  { payer: p[5], amount_local: 36000, currency: jpy, title: "旅館宿泊費（蔵王）", payment_date: Date.new(2025, 3, 14), participant_ids: p.map(&:id) },
  { payer: p[6], amount_local: 7200, currency: jpy, title: "地元居酒屋ディナー", payment_date: Date.new(2025, 3, 15), participant_ids: p.map(&:id) },
  { payer: p[7], amount_local: 8900, currency: jpy, title: "山形名物芋煮昼食代", payment_date: Date.new(2025, 3, 16), participant_ids: [p[0].id, p[2].id, p[5].id, p[7].id] },
  { payer: p[0], amount_local: 5000, currency: jpy, title: "蔵王の樹氷観光チケット", payment_date: Date.new(2025, 3, 16), participant_ids: p.map(&:id) },
  { payer: p[1], amount_local: 2000, currency: jpy, title: "カフェ代", payment_date: Date.new(2025, 3, 17), participant_ids: [p[1].id, p[3].id, p[6].id] },
  { payer: p[2], amount_local: 4443, currency: jpy, title: "ガソリン代", payment_date: Date.new(2025, 3, 15), participant_ids: p.map(&:id) },
  { payer: p[3], amount_local: 2800, currency: jpy, title: "高速道路料金", payment_date: Date.new(2025, 3, 14), participant_ids: p.map(&:id) },
  { payer: p[4], amount_local: 5600, currency: jpy, title: "酒蔵見学費", payment_date: Date.new(2025, 3, 17), participant_ids: [p[0].id, p[4].id, p[5].id] },
  { payer: p[5], amount_local: 3169, currency: jpy, title: "お土産代（地酒・お菓子）", payment_date: Date.new(2025, 3, 18), participant_ids: p.map(&:id) },
  { payer: p[6], amount_local: 8730, currency: jpy, title: "昼食（米沢牛ステーキ）", payment_date: Date.new(2025, 3, 18), participant_ids: [p[2].id, p[6].id, p[7].id] },
  { payer: p[7], amount_local: 9532, currency: jpy, title: "旅の打ち上げディナー", payment_date: Date.new(2025, 3, 18), participant_ids: p.map(&:id) }
]

expenses_data.each do |data|
  expense = trip.expenses.create!(
    payer: data[:payer],
    amount_local: data[:amount_local],
    currency: data[:currency],
    title: data[:title],
    payment_date: data[:payment_date],
    advance_payments_attributes: data[:participant_ids].map { |id| { participant_id: id } }
  )
  ExpenseAmountDistributor.new(expense).call
end
#-----------------------------------------





#-----------------------------------------
trip = user.trips.create!(currency: jpy, title: "和歌山ぶらり日帰り旅", departure_date: Date.new(2025, 4, 13), settlement_status: 1,
  participants_attributes: [
    { name: "さとし" }, { name: "ゆうき" }, { name: "たくや" }
  ]
)
p = trip.participants.order(:id)
expenses_data = [
  { payer: p[0], amount_local: 7800, currency: jpy, title: "レンタカー代", payment_date: Date.new(2025, 4, 13), participant_ids: p.map(&:id) },
  { payer: p[1], amount_local: 5495, currency: jpy, title: "ガソリン代", payment_date: Date.new(2025, 4, 13), participant_ids: p.map(&:id) },
  { payer: p[2], amount_local: 3600, currency: jpy, title: "とれとれ市場の昼食代", payment_date: Date.new(2025, 4, 13), participant_ids: p.map(&:id) },
  { payer: p[0], amount_local: 2700, currency: jpy, title: "白浜温泉入浴料", payment_date: Date.new(2025, 4, 13), participant_ids: p.map(&:id) },
  { payer: p[1], amount_local: 1530, currency: jpy, title: "カフェ・スイーツ代", payment_date: Date.new(2025, 4, 13), participant_ids: [p[1].id, p[2].id] },
  { payer: p[2], amount_local: 2103, currency: jpy, title: "お土産（梅干し・みかんジュース）", payment_date: Date.new(2025, 4, 13), participant_ids: p.map(&:id) }
]
expenses_data.each do |data|
  expense = trip.expenses.create!(
    payer: data[:payer],
    amount_local: data[:amount_local],
    currency: data[:currency],
    title: data[:title],
    payment_date: data[:payment_date],
    advance_payments_attributes: data[:participant_ids].map { |id| { participant_id: id } }
  )
  ExpenseAmountDistributor.new(expense).call
end
#--------------------------------------






#-----------------------------------------
trip = user.trips.create!(currency: jpy, title: "四万十・夏の川旅2025", departure_date: Date.new(2025, 8, 13), settlement_status: 0,
  participants_attributes: [
    { name: "あきら" }, { name: "なつみ" }, { name: "たいち" }, { name: "かな" }, { name: "けん" }
  ]
)
p = trip.participants.order(:id)
expenses_data = [
  { payer: p[0], amount_local: 24000, currency: jpy, title: "レンタカー代（3日間）", payment_date: Date.new(2025, 8, 13), participant_ids: p.map(&:id) },
  { payer: p[1], amount_local: 7834, currency: jpy, title: "ガソリン代", payment_date: Date.new(2025, 8, 13), participant_ids: p.map(&:id) },
  { payer: p[2], amount_local: 13800, currency: jpy, title: "宿泊費（古民家宿）", payment_date: Date.new(2025, 8, 13), participant_ids: p.map(&:id) },
  { payer: p[3], amount_local: 3600, currency: jpy, title: "川サウナ利用料", payment_date: Date.new(2025, 8, 14), participant_ids: p.map(&:id) },
  { payer: p[4], amount_local: 4231, currency: jpy, title: "BBQ食材代", payment_date: Date.new(2025, 8, 14), participant_ids: p.map(&:id) },
  { payer: p[0], amount_local: 5200, currency: jpy, title: "昼食代（鰹のたたき定食）", payment_date: Date.new(2025, 8, 13), participant_ids: [p[0].id, p[1].id, p[2].id] },
  { payer: p[1], amount_local: 1800, currency: jpy, title: "花火代", payment_date: Date.new(2025, 8, 14), participant_ids: p.map(&:id) },
  { payer: p[2], amount_local: 3000, currency: jpy, title: "道の駅スイーツ・飲み物", payment_date: Date.new(2025, 8, 13), participant_ids: [p[2].id, p[3].id, p[4].id] },
  { payer: p[3], amount_local: 7200, currency: jpy, title: "夕食（地元居酒屋）", payment_date: Date.new(2025, 8, 14), participant_ids: p.map(&:id) },
  { payer: p[4], amount_local: 2740, currency: jpy, title: "川遊び道具レンタル", payment_date: Date.new(2025, 8, 13), participant_ids: [p[0].id, p[4].id] },
  { payer: p[0], amount_local: 1500, currency: jpy, title: "温泉施設入浴料", payment_date: Date.new(2025, 8, 15), participant_ids: [p[1].id, p[2].id, p[0].id] },
  { payer: p[1], amount_local: 3859, currency: jpy, title: "お土産代（芋けんぴ・地酒など）", payment_date: Date.new(2025, 8, 15), participant_ids: p.map(&:id) }
]
expenses_data.each do |data|
  expense = trip.expenses.create!(
    payer: data[:payer],
    amount_local: data[:amount_local],
    currency: data[:currency],
    title: data[:title],
    payment_date: data[:payment_date],
    advance_payments_attributes: data[:participant_ids].map { |id| { participant_id: id } }
  )
  ExpenseAmountDistributor.new(expense).call
end
#-----------------------------------------

