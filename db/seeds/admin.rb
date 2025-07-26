User.create!(
  name: ENV["ADMIN_USERNAME"],
  email: ENV["ADMIN_EMAIL"],
  password: ENV["ADMIN_PASS"],
  role: :admin
)