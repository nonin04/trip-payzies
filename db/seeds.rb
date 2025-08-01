begin

  user = User.find_by(email: "example@email.com")
  if user
    user.trips.destroy_all
    user.destroy
  end

  # 旅行記録ファイル
  load Rails.root.join("db/seeds/admin.rb")
  load Rails.root.join("db/seeds/test_data.rb")
  load Rails.root.join("db/seeds/demo_data.rb")


  puts "--------insights--------"
  puts "users: #{User.count}"
  puts "trips: #{Trip.count}"
  puts "expenses: #{Expense.count}"
  puts "groups: #{Group.count}"
  puts "【Exchange Rates】"
  puts "▶︎ yesterday: #{ExchangeRate.where(rate_date: Date.current - 1).count} "
  puts "▶︎ 2days before: #{ExchangeRate.where(rate_date: Date.current - 2).count} "
  puts "▶︎ 3days before: #{ExchangeRate.where(rate_date: Date.current - 3).count} "
  puts "-----------------------"


  rescue ActiveRecord::RecordInvalid => e
  puts "バリデーションエラー: #{e.record.errors.full_messages.join(', ')}"
  raise e

end
