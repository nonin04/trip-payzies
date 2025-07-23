user = User.find_by!(email: "example@email.com")

# 既存グループ（参考）
gA = user.groups.create!(name: "大学ゼミ友達")
[ "あきら", "みさき", "けんと", "ゆうこ", "はるな", "りく", "まこと", "さえ" ].each do |name|
  gA.members.create!(name: name)
end

# グループ：高校仲良し3人組
gB = user.groups.create!(name: "高校仲良し3人組")
[ "ゆうき", "ひろと", "たいし" ].each do |name|
  gB.members.create!(name: name)
end

# グループ：日本高校100期生
gC = user.groups.create!(name: "日本高校100期生")
[ "けいご", "はづき", "れお", "さくら", "たいち", "まゆ", "そら", "えり", "しゅん", "のぞみ" ].each do |name|
  gC.members.create!(name: name)
end

# グループ：会社同期
gD = user.groups.create!(name: "会社同期")
[ "ゆか", "たくや", "みお", "しんじ", "まな", "だいち", "さや", "けん", "なお", "かな" ].each do |name|
  gD.members.create!(name: name)
end
