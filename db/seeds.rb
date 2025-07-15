begin

  user = User.find_by(email: "example@email.com")
  if user
    user.trips.destroy_all
    user.destroy
  end

userA = User.create!(
    name: "test_user",
    email: "example@email.com",
    password: "password"
  )

 # 旅行記録ファイル
  load Rails.root.join("db/seeds/groups.rb")
  load Rails.root.join("db/seeds/trips_data.rb")
  load Rails.root.join("db/seeds/full_length_check.rb")
  load Rails.root.join("db/seeds/trips_share_token_seeds.rb")

  puts "📊 現在のデータ状況"
  puts "-----------------------"
  puts "👤 ユーザー数: #{User.count}"
  puts "🧳 旅行数: #{Trip.count}"
  puts "💸 立替記録数: #{Expense.count}"
  User.all.each do |user|
    puts user.email
  end
  puts "-----------------------"


  rescue ActiveRecord::RecordInvalid => e
  puts "バリデーションエラー: #{e.record.errors.full_messages.join(', ')}"
  raise e

end
