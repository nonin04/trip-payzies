require 'rails_helper'

RSpec.describe "Expenses", type: :request do
  let(:user) { create(:user) }
  let(:jpy_currency) { create(:currency, :jpy) }
  let(:trip) { create(:trip, :with_participants, user: user, currency: jpy_currency, participants_count: 3) }
  let!(:expense) { create(:expense, :with_advance_payments, :with_payer, trip: trip, currency: jpy_currency) }

  before do
    sign_in user
  end
  #--------------------------------------------------
  describe "GET /show" do
    it "正常にアクセスできること" do
      get trip_expense_path(trip, expense)
      expect(response).to have_http_status(200)
    end
  end
  #--------------------------------------------------
  describe "GET /new" do
    it "正常にアクセスできること" do
      get new_trip_expense_path(trip)
      expect(response).to have_http_status(200)
    end
  end
  #--------------------------------------------------
  describe "POST /create" do
    it "有効なパラメータで立替が作成されること" do
      participant_ids = trip.participants.pluck(:id)
      expense_and_advance_payments_params = attributes_for(:expense).merge(
        trip_id: trip.id,
        currency_id: jpy_currency.id,
        payer_id: participant_ids[0],
        advance_payments_attributes: [
          { participant_id: participant_ids[0], amount: 500 },
          { participant_id: participant_ids[1], amount: 500 }
        ]
      )
      expect {
        post trip_expenses_path(trip), params: { expense: expense_and_advance_payments_params }
      }.to change(Expense, :count).by(1)
      expect(response).to redirect_to(trip_path(trip))
    end

    it "対象者0で立替作成が失敗しエラーステータスが返ること" do
      participant_ids = trip.participants.pluck(:id)
      expense_and_advance_payments_params = attributes_for(:expense).merge(
        trip_id: trip.id,
        currency_id: jpy_currency.id,
        payer_id: participant_ids[0],
        advance_payments_attributes: []
      )
      post trip_expenses_path(trip), params: { expense: expense_and_advance_payments_params }
      expect(response).to have_http_status(422)
      expect(response.body.scan(/data-expense-validate-target="checkBox"/).size).to eq(trip.participants.size)
    end
  end
  #--------------------------------------------------
  describe "GET /edit" do
    it "正常にアクセスできること" do
      get edit_trip_expense_path(trip, expense)
      expect(response).to have_http_status(200)
    end
  end
  #--------------------------------------------------
  describe "PATCH /update" do
    it "有効なパラメータで立替の項目名が更新されること" do
      participant_ids = trip.participants.pluck(:id)
      expense_and_advance_payments_update_params = attributes_for(:expense).merge(
        title: "立替テスト2",
        advance_payments_attributes: [
          { participant_id: participant_ids[0], amount: 500 },
          { participant_id: participant_ids[1], amount: 500 }
        ]
      )

      patch trip_expense_path(trip, expense), params: { expense: expense_and_advance_payments_update_params }
      expect(response).to redirect_to(trip_path(trip))
      expense.reload
      expect(expense.title).to eq("立替テスト2")
      follow_redirect!
      expect(response.body).to include("立替テスト2")
    end
  end

  describe "PATCH /update" do
    it "対象者を0人で更新に失敗しエラーステータスが返ること" do
      participant_ids = trip.participants.pluck(:id)
      expense_and_advance_payments_update_params = attributes_for(:expense).merge(
        title: "立替テスト2",
        advance_payments_attributes: []
      )
      patch trip_expense_path(trip, expense), params: { expense: expense_and_advance_payments_update_params }
      expect(response).to have_http_status(422)
    end
  end
  #--------------------------------------------------
  describe "DELETE /destroy" do
    it "立替記録が正常に削除され旅行詳細にリダイレクトすること" do
      expect { delete trip_expense_path(trip, expense) }.to change(Expense, :count).by(-1)
      expect(response).to redirect_to(trip_path(trip))
      expect(flash[:notice]).to eq("立替記録を1件削除しました。")
    end
  end
end
