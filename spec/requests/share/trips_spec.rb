require 'rails_helper'

RSpec.describe "Share::Trips", type: :request do
  let(:user) { create(:user) }
  let(:jpy_currency) { create(:currency, :jpy) }
  let(:trip) { create(:trip, :with_participants, user: user, currency: jpy_currency, participants_count: 3) }

  describe "GET /show" do
    it "正常にアクセスできること" do
      get share_trip_path(trip.share_token)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /insight" do
    it "正常にアクセスできること" do
      get insights_share_trip_path(trip.share_token)
      expect(response).to have_http_status(200)
      amount = trip.expenses.map(&:amount).sum
      expect(response.body).to include(amount.to_s)
      expect(response.body).to include('<canvas')
    end
  end

  describe "GET /result (精算結果)" do
    context "立替記録がある場合" do
      let!(:expense) { create(:expense, :with_advance_payments, :with_payer, trip: trip, currency: jpy_currency) }
      it "正常にアクセスできること" do
        get result_share_trip_path(trip.share_token)
        expect(response).to have_http_status(200)
      end
    end
    context "立替記録がない場合" do
      it "アクセスに失敗しflashが表示されること" do
        get result_share_trip_path(trip.share_token)
        expect(flash[:alert]).to eq("精算記録がありません。")
      end
    end
  end
end
