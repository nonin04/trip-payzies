require 'rails_helper'

# APIのリクエストを消費するため
# 為替レート取得検証時のみskipをitに変更して実行

RSpec.describe "Api::ExchangeRates", type: :request do
  describe "GET /api/exchange_rates" do
    skip "正常系(リクエスト消費のため検証時のみ実行)" do
      headers = { "X-Secret-Key" => ENV["RATE_FETCH_SECRET_KEY"] }
      post api_fetch_exchange_rate_path, headers: headers
      expect(response).to have_http_status(200)
    end

    skip "異常系(リクエスト消費のため検証時のみ実行)" do
      headers = { "X-Secret-Key" => "abcde" }
      post api_fetch_exchange_rate_path, headers: headers
      expect(response).to have_http_status(401)
    end
  end
end
