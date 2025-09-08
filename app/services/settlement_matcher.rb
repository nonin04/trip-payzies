# 精算処理のクラス
class SettlementMatcher
  def initialize(trip)
    @trip = trip
    @balances = BalanceCalculator.new(trip).balances
  end

  def spliter
    creditor = [] # 債権者のハッシュ
    debtor = [] # 負債者のハッシュ
      # 差額の正負によって各参加者を仕分ける [参加者と差額のハッシュ] ※差額が0の参加者は精算に関係ないため無視
      @balances.each do |b|
        if b[:difference] > 0
          creditor << { participant: b[:participant], difference: b[:difference] }
        elsif b[:difference] < 0
          debtor << { participant: b[:participant], difference: b[:difference] }
        end
      end
    { creditor: creditor, debtor: debtor }
  end


  def settlements
    # spliterで作成した各ハッシュをコピー(dup) ※dupメソッドは1段下の階層までしかコピーしない
    # 債権者リストと負債者リストのハッシュをコピー
    creditors = spliter[:creditor].map { |c| c.dup }
    debtors = spliter[:debtor].map { |c| c.dup }
    results = []


    creditors.each do |c|
      while c[:difference] > 0 && !debtors.empty?
        debtor = debtors.first
        # 債権者の差額と負債者の差額の小さい方の額をpaymentとする
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
end
