require 'rails_helper'

RSpec.describe Expense, type: :model do
  let!(:jpy_currency) { create(:currency, :jpy) }
  let!(:usd_currency) { create(:currency, :usd) }

  describe 'バリデーション' do
    context '通貨の検証' do
      context 'usd' do
        let!(:trip_usd) { create(:trip, :trip_usd) }
          
          it '米ドル立替で7/19以前の場合エラー' do
            expense = build(:expense, :usd_date_too_old, trip: trip_usd, currency: usd_currency )
            expect(expense).not_to be_valid
            expect(expense.errors[:payment_date]).to include("2025/7/19~今日までの日付を選択してください")
          end

          it '米ドル立替で未来の日付の場合エラー' do
            expense = build(:expense, :usd_in_future_date, trip: trip_usd, currency: usd_currency )
            expect(expense).not_to be_valid
            expect(expense.errors[:payment_date]).to include("2025/7/19~今日までの日付を選択してください")
          end
        end

      context 'jpy' do
        let!(:trip_jpy) { create(:trip, :trip_jpy) }
        it '日本円で立替を正常に作成できる' do
          expense = build(:expense, :with_advance_payments, :with_payer, trip: trip_jpy)
          expect(expense).to be_valid
        end

        it '日本円立替で7/19以前の場合成功する' do
          expense = build(:expense, :jpy_date_too_old, trip: trip_jpy)
          expect(expense).to be_valid
        end

        it '日本円立替で未来の日付の場合成功する' do
          expense = build(:expense, :jpy_in_future_date, trip: trip_jpy)
          expect(expense).to be_valid
        end
      end
    end
#-----------------------------------------------------------------------
    context 'その他' do
      let!(:trip_jpy) { create(:trip, :trip_jpy) }
      it '決済者が選択されていないとエラー' do
        expense = build(:expense, :payer_null, trip: trip_jpy)
        expect(expense).not_to be_valid
      end

      it '対象者が選択されていないとエラー' do
        expense = build(:expense, :advance_payments_null, trip: trip_jpy)
        expect(expense).not_to be_valid
        expect(expense.errors[:base]).to include("対象者を一人以上設定してください")
      end


    end

  end
end