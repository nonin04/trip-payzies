require 'rails_helper'

RSpec.describe "Trips", type: :request do
  let(:user) { create(:user) }
  let!(:jpy_currency) { create(:currency, :jpy) }
  let!(:usd_currency) { create(:currency, :usd) }
  let!(:trip) { create(:trip, :with_participants, user: user, currency: jpy_currency, participants_count: 3) }
  before do
    sign_in user
  end
  #-------------------------------------------------
  describe "GET /index (旅行一覧ページ)" do
    it "正常にアクセスできて旅行タイトルが表示されること" do
      get trips_path
      expect(response).to have_http_status(200)
      expect(response.body).to include(trip.title)
    end
  end
  #-------------------------------------------------
  describe "GET /new (旅行作成フォーム)" do
    it "正常にアクセスできて参加者フォームが10個表示されること" do
      get new_trip_path
      expect(response).to have_http_status(200)
      expect(response.body.scan(/data-participant-validate-target="eachTemplate"/).size).to eq(10)
    end
  end
  #-------------------------------------------------
  describe "POST /create (旅行作成処理)" do
    it "有効なパラメータで旅行が作成されること" do
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

    it "無効なパラメータで旅行作成が失敗しエラーステータスが返ること" do
      trip_and_participants_params = attributes_for(:trip).merge(
        currency_id: jpy_currency.id,
        participants_attributes: [
          { name: "" }
        ]
      )
      post trips_path, params: { trip: trip_and_participants_params }
      expect(response).to have_http_status(422)
      expect(response.body.scan(/data-participant-validate-target="eachTemplate"/).size).to eq(10)
    end
  end
  #-------------------------------------------------
  describe "GET /show (旅行詳細ページ)" do
    it "共有用リンクのトークンが表示されていること" do
      get trip_path(trip)
      expect(response).to have_http_status(200)
      expect(response.body).to include(trip.share_token)
    end
  end
  #-------------------------------------------------
  describe "GET /insights (旅行集計ページ)" do
    it "グラフや合計金額が表示されていること" do
      get insights_trip_path(trip)
      expect(response).to have_http_status(200)
      amount = trip.expenses.map(&:amount).sum
      expect(response.body).to include(amount.to_s)
      expect(response.body).to include('<canvas')
    end
  end
  #-------------------------------------------------
  describe "PATCH /update (旅行情報更新処理)" do
    it "有効なパラメータで旅行タイトルが更新されること" do
      patch trip_path(trip), params: { trip: { title: "旅行テスト2" } }
      expect(response).to redirect_to(trip_path(trip))
      trip.reload
      expect(trip.title).to eq("旅行テスト2")
      follow_redirect!
      expect(response.body).to include("旅行テスト2")
    end

    it "通貨変更は反映されず元のままであること" do
      patch trip_path(trip), params: { trip: { currency_id: usd_currency.id } }
      expect(response).to redirect_to(trip_path(trip))
      trip.reload
      expect(trip.currency.code).to eq("JPY")
      follow_redirect!
      expect(response.body).not_to include("USD")
    end

    it "タイトルが長すぎるとバリデーションエラーとなること" do
      patch trip_path(trip), params: { trip: { title: "文字数カウントの上限のバリデーションをチェックします" } }
      expect(response).to have_http_status(422)
    end
  end
  #-------------------------------------------------
  describe "DELETE /destroy (旅行削除処理)" do
    it "旅行が正常に削除され一覧にリダイレクトすること" do
      expect {
        delete trip_path(trip)
      }.to change(Trip, :count).by(-1)
      expect(response).to redirect_to(trips_path)
    end
  end
  #-------------------------------------------------
  describe "GET /result (精算結果)" do
    context "立替記録がある場合" do
      let!(:expense) { create(:expense, :with_advance_payments, :with_payer, trip: trip, currency: jpy_currency) }
      it "正常にアクセスできること" do
        get result_trip_path(trip)
        expect(response).to have_http_status(200)
      end
    end
    context "立替記録がない場合" do
      it "アクセスに失敗しflashが表示されること" do
        get result_trip_path(trip)
        expect(flash[:alert]).to eq("精算記録がありません。")
      end
    end
  end
  #-------------------------------------------------
  describe "POST /settle (精算済み更新処理)" do
    context "正常系" do
      it "旅行の精算状況を精算済みに更新できること" do
        patch settle_trip_path(trip)
        trip.reload
        expect(trip.settlement_status).to eq("settled")
      end
    end
  end
  #-------------------------------------------------
  describe "POST /unsettle (未精算更新処理)" do
    it "旅行の精算状況を未精算に更新できること" do
      patch unsettle_trip_path(trip)
      trip.reload
      expect(trip.settlement_status).to eq("unsettled")
    end
  end
  #-------------------------------------------------
end
