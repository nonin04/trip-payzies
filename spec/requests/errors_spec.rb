require 'rails_helper'

RSpec.describe "Errors", type: :request do
  describe "Errors" do
    it "404エラーが返ること" do
      get "/404"
      expect(response).to have_http_status(:not_found)
      expect(response.body).to include("指定されたページが見つかりませんでした")
    end

    it "500エラーが返ること" do
      get "/500"
      expect(response).to have_http_status(:internal_server_error)
      expect(response.body).to include("申し訳ございません")
    end

    it "422エラーが返ること" do
      get "/422"
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("送信された内容に")
    end
  end
end
