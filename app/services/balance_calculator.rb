class BalanceCalculator
  def initialize(trip)
    @trip = trip
    @expenses = trip.expenses.includes(:payer, :participants, :advance_payments)
  end


  #各参加者の差額を出す
  def Balance

    @expenses.each do |e|
      paid_participant = e.payer
      owed_participants = 


    end



  end
end