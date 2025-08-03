require 'rails_helper'

RSpec.describe Trip, type: :model do
  let!(:user) { create(:user) }
  let!(:jpy_currency) { create(:currency, :jpy) }
  let!(:usd_currency) { create(:currency, :usd) }

  describe 'バリデーション' do
    context '正常系' do
      it '旅行を正常に作成できる' do
        trip = build(:trip, :with_participants, user: user, currency: jpy_currency, participants_count: 3)
        expect(trip).to be_valid
      end

      it '日本円で旅行を作成できる' do
        trip = build(:trip, :trip_jpy, user: user)
        expect(trip).to be_valid
      end

      it '米ドルで旅行を作成できる' do
        trip = build(:trip, :trip_usd, user: user)
        expect(trip).to be_valid
      end
    end

    context '異常系' do
      it '参加者が11人以上の場合はエラー' do
        trip = build(:trip, :participants_within_10, user: user, currency: jpy_currency)
        expect(trip).not_to be_valid
      end

      it 'タイトルが25文字以上だとエラー' do
        trip = build(:trip, title: "文字数カウントの上限のバリデーションをチェックします")
        expect(trip).not_to be_valid
      end

      it 'タイトルがnilの場合はエラー' do
        trip = build(:trip, title: nil)
        expect(trip).not_to be_valid
      end

      it 'currencyがnilの場合はエラー' do
        trip = build(:trip, currency: nil)
        expect(trip).not_to be_valid
      end

      it '参加者が1人もいない場合はエラー' do
        trip = build(:trip, :must_have_participant_at_least_one, user: user, currency: jpy_currency)
        expect(trip).not_to be_valid
      end
    end
  end


  describe '#reset_settlement_status' do
    let(:trip) { build(:trip, :with_participants, user: user, currency: jpy_currency, participants_count: 3, settlement_status: initial_status) }

    context '精算状況が精算済みの場合' do
      let(:initial_status) { :settled }

      it '精算状況を未精算にする' do
        trip.reset_settlement_status
        expect(trip.settlement_status).to eq 'unsettled'
      end
    end

    context '精算状況が未精算の場合' do
      let(:initial_status) { :unsettled }

      it '精算状況を変更しない' do
        trip.reset_settlement_status
        expect(trip.settlement_status).to eq 'unsettled'
      end
    end
  end
end
