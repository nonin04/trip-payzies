class BalanceCalculator
  def initialize(trip)
    @participants = trip.participants.includes(:advance_payments, :paid_expenses)
  end


  def balances
    balances = []
    @participants.each do |p|
      paid_total = 0
      owed_total = 0
      # 支払った額
      p.paid_expenses.each do |pe|
        paid_total += pe.amount
      end
      # 支払ってもらった額
      p.advance_payments.each do |ap|
        owed_total += ap.amount
      end
      balances << { participant: p, paid_total: paid_total, owed_total: owed_total }
    end
    balances
  end


  def net_balances
    net_balances = []
    balances.each do |b|
      difference = b[:paid_total] - b[:owed_total]
      net_balances << {participant: b[:participant], difference: difference}
    end
    net_balances
  end

end