require 'rails_helper'

RSpec.describe "Users::Registrations", type: :request do
  describe "登録後の処理" do
    it "topページに遷移すること" do
      post user_registration_path, params: { user: {
          name: "ユーザーネーム",
          email: "rspec@email.com",
          password: "password",
          password_confirmation: "password"
        }
      }
      expect(response).to redirect_to(trips_path)
      user = User.find_by(email: "rspec@email.com")
      expect(user).to be_present
    end
  end
end
