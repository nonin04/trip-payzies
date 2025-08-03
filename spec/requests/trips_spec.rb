require 'rails_helper'

RSpec.describe "Trips", type: :request do
  let(:user) { create(:user) }
  let(:jpy_currency) { create(:currency, :jpy) }
  let(:usd_currency) { create(:currency, :usd) }
  let!(:trip) { create(:trip, :with_participants, user: user, currency: jpy_currency, participants_count: 3) }

  before do
    sign_in user
  end
#-------------------------------------------------
  describe "GET /index" do
    it "レスポンスが正常か" do
      get trips_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(trip.title)
    end
  end
#-------------------------------------------------
  describe "POST /create" do
    it "旅行が作成されること" do
      trip_and_participants_params = attributes_for(:trip).merge(
        currency_id: jpy_currency.id,
        participants_attributes: [
          attributes_for(:participant),
          attributes_for(:participant)
        ]
      )
      expect {
        post trips_path, params: { trip: trip_and_participants_params }
      }.to change(Trip, :count).by(1)

      expect(response).to redirect_to(Trip.last)
      follow_redirect!
      expect(response.body).to include(Trip.last.title)
    end
  end
#-------------------------------------------------
  describe "GET /show" do
    it "共有リンクがあるか" do
      get trip_path(trip)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(trip.share_token)
    end
  end
#-------------------------------------------------
  describe "GET /insight" do
    it "グラフが表示されているか" do
      get insights_trip_path(trip)
      expect(response).to have_http_status(:ok)
      amount = trip.expenses.map(&:amount).sum
      expect(response.body).to include(amount.to_s)
      expect(response.body).to include('<canvas')
    end
  end
#-------------------------------------------------
  describe "PATCH /update" do

    it "旅行を正しく更新できるか" do
      patch trip_path(trip), params: { trip: { title: "旅行テスト2" } }
      expect(response).to redirect_to(trip_path(trip))
      trip.reload
      expect(trip.title).to eq("旅行テスト2")
      follow_redirect!
      expect(response.body).to include("旅行テスト2")
    end

    it "不正なパラメータを更新してしまわないか" do
      patch trip_path(trip), params: { trip: { currency_id: usd_currency.id } }
      expect(response).to redirect_to(trip_path(trip))
      trip.reload
      expect(trip.currency.code).to eq("JPY")
      follow_redirect!
      expect(response.body).not_to include("USD")
    end

    it "バリデーションエラーだとエラーになる" do
      patch trip_path(trip), params: { trip: { title: "文字数カウントの上限のバリデーションをチェックします" } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
#-------------------------------------------------
  describe "DELETE /destroy" do
    it "削除処理が機能する" do
      expect {
        delete trip_path(trip)
      }.to change(Trip, :count).by(-1)
      expect(response).to redirect_to(trips_path)
    end

  end
end
