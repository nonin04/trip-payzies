require 'rails_helper'

RSpec.describe "Applications", type: :request do
  let(:user) { create(:user) }

  describe "POST /user_session (ログイン処理)" do
    it "正しい情報でログイン後、旅行一覧ページにリダイレクトされること" do
      post user_session_path, params: { user: {
        email: user.email,
        password: user.password
      } }
      expect(response).to redirect_to(trips_path)
    end
  end

  describe "GET /trips (未ログイン状態で旅行一覧にアクセス)" do
    it "ログイン画面にリダイレクトされること" do
      get trips_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
