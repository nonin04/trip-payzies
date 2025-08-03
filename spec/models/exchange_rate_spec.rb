require 'rails_helper'

RSpec.describe ExchangeRate, type: :model do
  let!(:jpy_currency) { create(:currency, :jpy) }
  let!(:usd_currency) { create(:currency, :usd) }

  describe 'バリデーション' do
    context '正常系' do
      it '為替レートを正常に作成できる' do
        exchange_rate = build(:exchange_rate, :jpy_today, currency: jpy_currency)
        expect(exchange_rate).to be_valid
      end
    end

    context '異常系' do
      it '同じ日付のexchange_rateが存在するエラー' do
        exchange_rate = create(:exchange_rate, :jpy_today, currency: jpy_currency)
        exchange_rate2 = build(:exchange_rate, :jpy_today, currency: jpy_currency)
        expect(exchange_rate2).not_to be_valid
      end
    end


  end
end