class SettlementMatcher
  def initialize(trip)
    @trip = trip
    @expenses = trip.expenses
    @participants = trip.participants
    @net_balances = BalanceCalculator.new(trip).net_balances
  end

  def spliter
    creditor = [] # 債権者のハッシュ
    debtor = [] # 負債者のハッシュ
      # 差額の正負によって各参加者を仕分ける [参加者と差額のハッシュ] ※差額が0の参加者は精算に関係ないため無視

      @net_balances.each do |nb|   
        if nb[:difference] > 0
          creditor << {participant: nb[:participant],difference: nb[:difference]}
        elsif nb[:difference] < 0
          debtor << {participant: nb[:participant],difference: nb[:difference]}
        end
      end
    {creditor: creditor, debtor: debtor}
  end


  def settlements
    # spliterで作成した各ハッシュをコピー(dup) ※dupメソッドは1段下の階層までしかコピーしない
    creditors = spliter[:creditor].map{|c| c.dup}
    debtors = spliter[:debtor].map{|c| c.dup}
    results = []

    creditors.each do |c|
      while c[:difference] > 0 && !debtors.empty?
        debtor = debtors.first
        payment = [ c[:difference], -debtor[:difference] ].min
        results << { from: debtor[:participant], to:  c[:participant], amount: payment }

        # 支払いをもとに負債者、債権者の差額を更新
        c[:difference] -= payment
        debtor[:difference] += payment

        # 負債者(ハッシュの先頭)の差額が0になったらdupしたハッシュから削除
        if debtor[:difference] == 0
          debtors.shift 
        end
      end
    end
    results
  end


  def grouped_settlements
    # from:誰々でまとめた新しいハッシュを作成
    results = []
    @trip.participants.each do |p|
      payments = settlements.select{|s| s[:from] == p }.map{ |s| { to: s[:to], amount: s[:amount] } }
      results << { from: p, payments: payments } unless payments.empty?
    end
    results
  end

end
