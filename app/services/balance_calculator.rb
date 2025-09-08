# 参加者の負債・債権額及びその差額を出すクラス
class BalanceCalculator
  def initialize(trip)
    @participants = trip.participants.includes(:advance_payments, :paid_expenses)
  end

  def balances
    @participants.map do |p|
      { participant: p, paid_total: p.paid_total, owed_total: p.owed_total, difference: p.difference }
    end
  end
end
