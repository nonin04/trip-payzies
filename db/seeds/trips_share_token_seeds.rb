Trip.where(share_token: nil).find_each do |trip|
  token = SecureRandom.urlsafe_base64(10)
  trip.update!(share_token: token)
  puts "Trip ID=#{trip.id} に share_token=#{token} を設定"
end


