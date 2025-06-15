class SettlementMatcher
  def initialize(trip)
   @trip = trip
   @expenses = trip.expenses
   @participants = trip.participants
 end

 def call
   # ここにロジックを記載

 end
end

#呼び出し方
# @settlement_date = SettlementCalculator.new(@trip).call

end