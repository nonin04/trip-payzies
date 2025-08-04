require 'rails_helper'

RSpec.describe "Share::Expenses", type: :request do
  let(:user) { create(:user) }
  let(:jpy_currency) { create(:currency, :jpy) }
  let(:trip) { create(:trip, :with_participants, user: user, currency: jpy_currency, participants_count: 3) }
  let(:expense) { create(:expense, :with_advance_payments, :with_payer, trip: trip, currency: jpy_currency) }

  describe "GET /show" do
    it "正常にアクセスできること" do
      get share_trip_expense_path(trip.share_token, expense)
      expect(response).to have_http_status(200)
    end
  end
end
