# Tripモデルの表示用ラッパークラス
# ※draperを使用していない自作ラッパークラス
class TripDecorator
  def initialize(trip)
    @trip = trip
    @matcher = SettlementMatcher.new(trip)
  end

  def grouped_settlements
    # from:誰々でまとめた新しいハッシュを作成
    results = []
    @trip.participants.each do |p|
      payments = @matcher.settlements.select { |s| s[:from] == p }.map { |s| { to: s[:to], amount: s[:amount] } }
      results << { from: p, payments: payments } unless payments.empty?
    end
    results
  end
end
