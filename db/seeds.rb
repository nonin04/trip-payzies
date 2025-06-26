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
  load Rails.root.join("db/seeds/trips_data.rb")
  load Rails.root.join("db/seeds/full_length_check.rb")


  rescue ActiveRecord::RecordInvalid => e
  puts "バリデーションエラー: #{e.record.errors.full_messages.join(', ')}"
  raise e

end
