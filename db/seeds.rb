begin

  # テストユーザーとそのレコードを削除
  user = User.find_by(email: "example@email.com")
  if user
    user.trips.destroy_all
    user.destroy
  end

  ExchangeRate.destroy_all
  Currency.destroy_all

 # 旅行記録ファイル
  load Rails.root.join("db/seeds/currency.rb")
  load Rails.root.join("db/seeds/test_user.rb")
  load Rails.root.join("db/seeds/groups.rb")
  load Rails.root.join("db/seeds/trips_data.rb")
  load Rails.root.join("db/seeds/full_length_check.rb")


    #本デプロイ専用処理 (実行次第削除必須)
  #------------------------------------------------------------
  trips = Trip.all
  jpy_id = Currency.find_by(code: "JPY").id
  Trip.update_all(currency_id: jpy_id)
  
  #------------------------------------------------------------


  puts "--------insights--------"
  puts "users: #{User.count}"
  puts "trips: #{Trip.count}"
  puts "expenses: #{Expense.count}"
  User.all.each do |user|
    puts user.email
  end

  exchange_records = ExchangeRate.includes(:currency).all
  if exchange_records.any?
    exchange_records.each do |record|
      puts "#{record.rate_date}の#{record.currency.code}の為替レートは#{record.rate}です。"
    end
  else
    puts "為替レコードがありません。"
  end
  puts "-----------------------"


  rescue ActiveRecord::RecordInvalid => e
  puts "バリデーションエラー: #{e.record.errors.full_messages.join(', ')}"
  raise e

end
