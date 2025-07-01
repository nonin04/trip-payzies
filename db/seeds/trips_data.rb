userA = User.find_by(email: "example@email.com")

gA = Group.find_by(name:"大学ゼミ友達")
gB = Group.find_by(name:"高校仲良し3人組")
gC = Group.find_by(name:"日本高校100期生")
gD = Group.find_by(name:"会社同期")
#-----------------------------------------------------------------------------------------------------

trip1 = userA.trips.create!(
  group: gA,
  title: "Kyoto Trip",
  departure_date: Date.new(2024, 11, 2),
  participants_attributes: [
    { name: "Alice" }, { name: "Bob" }, { name: "Charlie" }, { name: "Diana" },
    { name: "Ethan" }, { name: "Fiona" }, { name: "George" }, { name: "Hannah" }
  ]
)
pA, pB, pC, pD, pE, pF, pG, pH = trip1.participants.order(:id)

expenses = [
  { payer: pA, amount: 2674, title: "Snacks & Drinks", date: Date.new(2024, 11, 1), participants: [pC, pE, pF, pG, pH] },
  { payer: pF, amount: 28630, title: "Rental Car", date: Date.new(2024, 11, 1), participants: trip1.participants },
  { payer: pG, amount: 1200, title: "Parking Fees", date: Date.new(2024, 11, 2), participants: [pA, pB, pC, pD, pE, pF, pH] },
  { payer: pE, amount: 76400, title: "Hotel Accommodation", date: Date.new(2025, 11, 3), participants: [pA, pF, pG, pH] },
  { payer: pB, amount: 9210, title: "Souvenirs", date: Date.new(2024, 11, 4), participants: [pB, pD] },
  { payer: pC, amount: 20670, title: "Bento Lunch", date: Date.new(2024, 11, 5), participants: [pB, pC, pD, pE, pF, pG, pH] },
  { payer: pF, amount: 73500, title: "Kimono rental", date: Date.new(2024, 11, 6), participants: trip1.participants },
  { payer: pB, amount: 29100, title: "Shinkansen chickets", date: Date.new(2025, 11, 7), participants: [pD, pE] },
  { payer: pC, amount: 4850, title: "Gasoline", date: Date.new(2024, 11, 8), participants: trip1.participants },
  { payer: pG, amount: 3400, title: "Ramen", date: Date.new(2024, 11, 9), participants: [pE, pF, pH] },
  { payer: pE, amount: 29400, title: "Dinner at Izakaya", date: Date.new(2024, 11, 10), participants: [pA, pC, pF, pG, pH] },
  { payer: pH, amount: 3000, title: "Temple Entrance Fees", date: Date.new(2024, 11, 11), participants: [pB, pC, pD, pE, pG] }
]

expenses.each do |e|
  expense = trip1.expenses.create!(
    payer: e[:payer],
    amount: e[:amount],
    title: e[:title],
    payment_date: e[:date],
    advance_payments_attributes: e[:participants].map { |p| { participant_id: p.id } }
  )
  ExpenseAmountDistributor.new(expense).call
end

#-----------------------------------------------------------------------------------------------------

trip2 = userA.trips.create!(
  group: gC,
  title: "北海道ニセコスキー",
  departure_date: Date.new(2024, 1, 5),
  participants_attributes: [
    { name: "ゆうじ" }, { name: "ともき" }, { name: "はると" }, { name: "さくら" },
    { name: "りな" }, { name: "なおこ" }, { name: "ひろし" }, { name: "だいち" }
  ]
)
p = trip2.participants.order(:id)

expenses_data = [
  { payer: p[0], amount: 4340,  title: "札幌ラーメン昼食代", payment_date: Date.new(2024,1,5),  participant_ids: [p[2].id, p[4].id, p[5].id, p[6].id, p[7].id] },
  { payer: p[5], amount: 28630, title: "お土産購入代", payment_date: Date.new(2024,1,7),  participant_ids: p.map(&:id) },
  { payer: p[6], amount: 2100,  title: "登別温泉入湯税", payment_date: Date.new(2024,1,8),  participant_ids: [p[0].id, p[1].id, p[2].id, p[3].id, p[4].id, p[5].id, p[7].id] },
  { payer: p[4], amount: 9640,  title: "夜市での食べ歩き代", payment_date: Date.new(2024,1,4),  participant_ids: [p[0].id, p[5].id, p[6].id, p[7].id] },
  { payer: p[1], amount: 10210, title: "海鮮丼代", payment_date: Date.new(2024,1,8),  participant_ids: [p[1].id, p[3].id] },
  { payer: p[2], amount: 26670, title: "スノーブーツレンタル代", payment_date: Date.new(2024,1,6),  participant_ids: [p[1].id, p[2].id, p[3].id, p[4].id, p[5].id, p[6].id, p[7].id] },
  { payer: p[5], amount: 73500, title: "民宿代(夕食オプション付)", payment_date: Date.new(2025,7,6),  participant_ids: p.map(&:id) },
  { payer: p[1], amount: 17000, title: "湖サウナ体験費", payment_date: Date.new(2024,1,7),  participant_ids: [p[3].id, p[4].id] },
  { payer: p[2], amount: 4850,  title: "ガソリン代", payment_date: Date.new(2024,1,8),  participant_ids: p.map(&:id) },
  { payer: p[6], amount: 2100,  title: "札幌駅 ロッカー", payment_date: Date.new(2024,1,7),  participant_ids: [p[4].id, p[5].id, p[7].id] },
  { payer: p[4], amount: 4200,  title: "ゆうじwifiレンタル立替", payment_date: Date.new(2024,1,6),  participant_ids: [p[0].id] },
  { payer: p[7], amount: 1460,  title: "洞爺湖遊覧船チケット", payment_date: Date.new(2024,1,8),  participant_ids: [p[1].id, p[2].id, p[3].id, p[4].id, p[6].id] }
]

expenses_data.each do |data|
  expense = trip2.expenses.create!(
    payer: data[:payer],
    amount: data[:amount],
    title: data[:title],
    payment_date: data[:payment_date],
    advance_payments_attributes: data[:participant_ids].map { |id| { participant_id: id } }
  )
  ExpenseAmountDistributor.new(expense).call
end

#--------------------------------------------------------------------------------------------------------

trip3 = userA.trips.create!(
  title: "沖縄離島めぐり旅",
  departure_date: Date.new(2024, 9, 10),
  participants_attributes: [
    { name: "あきら" }, { name: "みさき" }, { name: "けんと" }, { name: "ゆうこ" },
    { name: "はるな" }, { name: "りく" }, { name: "まこと" }, { name: "さえ" }
  ]
)
p1, p2, p3, p4, p5, p6, p7, p8 = trip3.participants.order(:id)

expenses = [
  { payer: p1, amount: 36800, title: "那覇〜石垣フェリー代", date: Date.new(2024, 9, 10), participants: trip3.participants },
  { payer: p3, amount: 12600, title: "石垣島レンタカー代", date: Date.new(2024, 9, 11), participants: [p1, p3, p4, p5, p7] },
  { payer: p6, amount: 8400, title: "川平湾グラスボート体験", date: Date.new(2024, 9, 11), participants: [p2, p5, p6, p8] },
  { payer: p2, amount: 29600, title: "宿泊費（竹富島民宿）", date: Date.new(2024, 9, 11), participants: trip3.participants },
  { payer: p4, amount: 5500, title: "竹富島レンタサイクル代", date: Date.new(2024, 9, 12), participants: [p1, p3, p4, p6] },
  { payer: p5, amount: 11800, title: "石垣牛焼肉ディナー", date: Date.new(2024, 9, 12), participants: [p2, p5, p6, p8] },
  { payer: p7, amount: 4600, title: "お土産（泡盛・ちんすこう）", date: Date.new(2024, 9, 13), participants: [p3, p4, p7] },
  { payer: p6, amount: 2050, title: "西表島フェリー港ロッカー", date: Date.new(2024, 9, 13), participants: [p6, p8] },
  { payer: p8, amount: 3360, title: "カフェ代（離島ターミナル）", date: Date.new(2024, 9, 13), participants: [p1, p2, p8] },
  { payer: p1, amount: 4980, title: "ドリンク＆軽食まとめ買い", date: Date.new(2024, 9, 10), participants: [p1, p2, p3, p4] },
  { payer: p3, amount: 9600, title: "ガソリン代（石垣島）", date: Date.new(2024, 9, 12), participants: trip3.participants }
]

expenses.each do |e|
  expense = trip3.expenses.create!(
    payer: e[:payer],
    amount: e[:amount],
    title: e[:title],
    payment_date: e[:date],
    advance_payments_attributes: e[:participants].map { |p| { participant_id: p.id } }
  )
  ExpenseAmountDistributor.new(expense).call
end

#--------------------------------------------------------------------------------------------------------

trip4 = userA.trips.create!(
  group: gD,
  title: "ヨーロッパ卒業旅行",
  departure_date: Date.new(2024, 3, 1),
  participants_attributes: [
    { name: "たかし" }, { name: "しゅん" }, { name: "けんと" }, { name: "りょう" },
    { name: "だいち" }, { name: "こうた" }, { name: "ゆうや" }, { name: "まさと" }
  ]
)
p = trip4.participants.order(:id)

expenses_data = [
  { payer: p[0], amount: 49800, title: "ユーレイルパス購入代", payment_date: Date.new(2024, 3, 1), participant_ids: p.map(&:id) },
  { payer: p[1], amount: 32500, title: "パリ市内観光バス代", payment_date: Date.new(2024, 3, 2), participant_ids: [p[0].id, p[1].id, p[3].id, p[4].id, p[7].id] },
  { payer: p[2], amount: 21500, title: "アムステルダム運河クルーズ", payment_date: Date.new(2024, 3, 4), participant_ids: [p[2].id, p[4].id, p[5].id, p[6].id] },
  { payer: p[4], amount: 33000, title: "Airbnb宿泊費（ロンドン）", payment_date: Date.new(2024, 3, 5), participant_ids: p.map(&:id) },
  { payer: p[3], amount: 5800, title: "ベルリンでのクラブ入場料", payment_date: Date.new(2024, 3, 6), participant_ids: [p[1].id, p[2].id, p[3].id, p[5].id, p[6].id] },
  { payer: p[5], amount: 14300, title: "夜のビール&つまみ代", payment_date: Date.new(2024, 3, 4), participant_ids: [p[0].id, p[5].id, p[6].id, p[7].id] },
  { payer: p[6], amount: 20800, title: "バルセロナFC観戦チケット", payment_date: Date.new(2024, 3, 7), participant_ids: [p[2].id, p[3].id, p[5].id, p[6].id] },
  { payer: p[7], amount: 4800, title: "トラム1日券（ウィーン）", payment_date: Date.new(2024, 3, 9), participant_ids: [p[0].id, p[1].id, p[2].id, p[7].id] },
  { payer: p[4], amount: 15400, title: "ドイツビール工場見学代", payment_date: Date.new(2024, 3, 6), participant_ids: [p[4].id, p[5].id, p[6].id] },
  { payer: p[5], amount: 20600, title: "ローマのピザ大食い大会", payment_date: Date.new(2024, 3, 8), participant_ids: [p[0].id, p[1].id, p[2].id, p[5].id] },
  { payer: p[0], amount: 7500, title: "地下鉄プリペイドカード代", payment_date: Date.new(2024, 3, 3), participant_ids: [p[0].id, p[3].id, p[4].id] }
]

expenses_data.each do |data|
  expense = trip4.expenses.create!(
    payer: data[:payer],
    amount: data[:amount],
    title: data[:title],
    payment_date: data[:payment_date],
    advance_payments_attributes: data[:participant_ids].map { |id| { participant_id: id } }
  )
  ExpenseAmountDistributor.new(expense).call
end

#--------------------------------------------------------------------------------------------------------

trip5 = userA.trips.create!(
  title: "九州温泉＆グルメ旅",
  departure_date: Date.new(2024, 11, 15),
  participants_attributes: [
    { name: "たかゆき" },
    { name: "みのり" },
    { name: "ゆうた" },
    { name: "まなみ" },
    { name: "けんじ" },
    { name: "さおり" }
  ]
)
p1, p2, p3, p4, p5, p6 = trip5.participants.order(:id)

expenses = [
  { payer: p1, amount: 28000, title: "別府温泉宿泊費", date: Date.new(2024, 11, 15), participants: [p1,p2,p3,p4,p5,p6] },
  { payer: p2, amount: 4500, title: "地獄めぐり入場料", date: Date.new(2024, 11, 16), participants: [p1,p2,p3,p6] },
  { payer: p3, amount: 7800, title: "熊本馬刺しディナー", date: Date.new(2024, 11, 16), participants: [p3,p4,p5] },
  { payer: p4, amount: 5900, title: "長崎ちゃんぽんランチ", date: Date.new(2024, 11, 17), participants: [p1,p2,p4,p6] },
  { payer: p5, amount: 3600, title: "黒川温泉足湯代", date: Date.new(2024, 11, 17), participants: [p3,p5,p6] },
  { payer: p6, amount: 10200, title: "福岡屋台飲み会代", date: Date.new(2024, 11, 17), participants: [p1,p2,p3,p4,p5,p6] },
  { payer: p1, amount: 4700, title: "高速バス代（博多⇄別府）", date: Date.new(2024, 11, 15), participants: [p1,p2,p3,p4,p5,p6] },
  { payer: p2, amount: 3900, title: "温泉街お土産代", date: Date.new(2024, 11, 16), participants: [p2,p4,p6] },
  { payer: p3, amount: 5200, title: "阿蘇観光バス代", date: Date.new(2024, 11, 16), participants: [p1,p3,p5] },
  { payer: p4, amount: 2300, title: "カフェ代（長崎）", date: Date.new(2024, 11, 17), participants: [p4,p6] }
]

expenses.each do |e|
  expense = trip5.expenses.create!(
    payer: e[:payer],
    amount: e[:amount],
    title: e[:title],
    payment_date: e[:date],
    advance_payments_attributes: e[:participants].map { |p| { participant_id: p.id } }
  )
  ExpenseAmountDistributor.new(expense).call
end

#-----------------------------------------------------------------------------------------------------

trip6 = userA.trips.create!(
  title: "東北自然満喫キャンプ旅",
  departure_date: Date.new(2024, 8, 5),
  participants_attributes: [
    { name: "しんじ" },
    { name: "あやか" },
    { name: "ゆうき" },
    { name: "まゆ" }
  ]
)
p1, p2, p3, p4 = trip6.participants.order(:id)

expenses = [
  { payer: p1, amount: 12500, title: "キャンプ場宿泊費", date: Date.new(2024, 8, 5), participants: [p1,p2,p3,p4] },
  { payer: p2, amount: 3500, title: "BBQ食材購入代", date: Date.new(2024, 8, 5), participants: [p1,p2,p3,p4] },
  { payer: p3, amount: 2800, title: "温泉入浴料", date: Date.new(2024, 8, 6), participants: [p2,p3,p4] },
  { payer: p4, amount: 4300, title: "釣り道具レンタル代", date: Date.new(2024, 8, 6), participants: [p1,p3] },
  { payer: p1, amount: 6000, title: "ガソリン代", date: Date.new(2024, 8, 5), participants: [p1,p2,p3,p4] },
  { payer: p2, amount: 1600, title: "キャンプ用品雑費", date: Date.new(2024, 8, 5), participants: [p2] },
  { payer: p3, amount: 2200, title: "夜の焚き火おやつ代", date: Date.new(2024, 8, 6), participants: [p1,p3,p4] },
  { payer: p4, amount: 3000, title: "地元スーパー買い出し", date: Date.new(2024, 8, 5), participants: [p1,p2,p3,p4] },
  { payer: p1, amount: 1400, title: "キャンプ場駐車料金", date: Date.new(2024, 8, 5), participants: [p1,p2,p3,p4] },
  { payer: p2, amount: 5000, title: "温泉街食事代", date: Date.new(2024, 8, 6), participants: [p2,p4] }
]

expenses.each do |e|
  expense = trip6.expenses.create!(
    payer: e[:payer],
    amount: e[:amount],
    title: e[:title],
    payment_date: e[:date],
    advance_payments_attributes: e[:participants].map { |p| { participant_id: p.id } }
  )
  ExpenseAmountDistributor.new(expense).call
end

#-----------------------------------------------------------------------------------------------------

trip7 = userA.trips.create!(
  title: "NYC Sightseeing Trip",
  departure_date: Date.new(2024, 10, 20),
  participants_attributes: [
    { name: "John" },
    { name: "Mike" },
    { name: "Sarah" },
    { name: "Emily" },
    { name: "David" }
  ]
)
p1, p2, p3, p4, p5 = trip7.participants.order(:id)

expenses = [
  { payer: p1, amount: 35000, title: "Flight tickets", date: Date.new(2024, 10, 20), participants: [p1,p2,p3,p4,p5] },
  { payer: p2, amount: 12000, title: "Broadway show tickets", date: Date.new(2024, 10, 21), participants: [p1,p2,p3,p5] },
  { payer: p3, amount: 8000, title: "Central Park bike rental", date: Date.new(2024, 10, 22), participants: [p2,p3,p4] },
  { payer: p4, amount: 27000, title: "Hotel accommodation", date: Date.new(2024, 10, 20), participants: [p1,p2,p3,p4,p5] },
  { payer: p5, amount: 9000, title: "Dinner at Times Square", date: Date.new(2024, 10, 22), participants: [p4,p5] },
  { payer: p1, amount: 4000, title: "Subway weekly pass", date: Date.new(2024, 10, 21), participants: [p1,p2,p3,p4,p5] },
  { payer: p2, amount: 6500, title: "Museum tickets", date: Date.new(2024, 10, 23), participants: [p1,p3,p5] },
  { payer: p3, amount: 2300, title: "Coffee and snacks", date: Date.new(2024, 10, 21), participants: [p2,p3] },
  { payer: p4, amount: 5000, title: "Taxi rides", date: Date.new(2024, 10, 22), participants: [p1,p4] },
  { payer: p5, amount: 16000, title: "Shopping spree", date: Date.new(2024, 10, 23), participants: [p3,p5] }
]

expenses.each do |e|
  expense = trip7.expenses.create!(
    payer: e[:payer],
    amount: e[:amount],
    title: e[:title],
    payment_date: e[:date],
    advance_payments_attributes: e[:participants].map { |p| { participant_id: p.id } }
  )
  ExpenseAmountDistributor.new(expense).call
end

#-----------------------------------------------------------------------------------------------------

trip8 = userA.trips.create!(
  title: "南国リゾート家族旅行",
  departure_date: Date.new(2024, 12, 20),
  participants_attributes: [
    { name: "ゆうた" },
    { name: "えみ" },
    { name: "りょうた" },
    { name: "かなえ" }
  ]
)
p1, p2, p3, p4 = trip8.participants.order(:id)

expenses = [
  { payer: p1, amount: 42000, title: "ホテル宿泊費", date: Date.new(2024, 12, 20), participants: [p1,p2,p3,p4] },
  { payer: p2, amount: 8500, title: "海水浴場入場料", date: Date.new(2024, 12, 21), participants: [p1,p2,p4] },
  { payer: p3, amount: 6300, title: "シュノーケリングレンタル代", date: Date.new(2024, 12, 21), participants: [p1,p3] },
  { payer: p4, amount: 15000, title: "家族ディナー代", date: Date.new(2024, 12, 21), participants: [p1,p2,p3,p4] },
  { payer: p1, amount: 7200, title: "レンタカー代", date: Date.new(2024, 12, 20), participants: [p1,p3,p4] },
  { payer: p2, amount: 2400, title: "アイスクリーム購入代", date: Date.new(2024, 12, 21), participants: [p2] },
  { payer: p3, amount: 5100, title: "水族館入場料", date: Date.new(2024, 12, 22), participants: [p1,p3,p4] },
  { payer: p4, amount: 3900, title: "お土産代", date: Date.new(2024, 12, 22), participants: [p2,p4] },
  { payer: p1, amount: 4500, title: "駐車場料金", date: Date.new(2024, 12, 20), participants: [p1,p2,p3,p4] },
  { payer: p2, amount: 8000, title: "温泉入浴料", date: Date.new(2024, 12, 22), participants: [p1,p2,p3,p4] }
]

expenses.each do |e|
  expense = trip8.expenses.create!(
    payer: e[:payer],
    amount: e[:amount],
    title: e[:title],
    payment_date: e[:date],
    advance_payments_attributes: e[:participants].map { |p| { participant_id: p.id } }
  )
  ExpenseAmountDistributor.new(expense).call
end

#-----------------------------------------------------------------------------------------------------


