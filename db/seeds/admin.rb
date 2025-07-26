User.find_or_create_by!(email: ENV["ADMIN_EMAIL"]) do |user|
  user.name = ENV["ADMIN_USERNAME"]
  user.password = ENV["ADMIN_PASS"]
  user.role = :admin
end
