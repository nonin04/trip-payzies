class BalanceCalculator
  def initialize(trip)
    @participants = trip.participants.includes(:advance_payments, :paid_expenses)
  end

  def balances
    @participants.map do |p|
      paid_total = p.paid_expenses.sum(&:amount)
      owed_total = p.advance_payments.sum(&:amount)
      { participant: p, paid_total: paid_total, owed_total: owed_total }
    end
  end

  def net_balances
    balances.map do |b|
      difference = b[:paid_total] - b[:owed_total]
      { participant: b[:participant], difference: difference }
    end
  end
end
