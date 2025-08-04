class ExpenseAmountSplitter
  # 人数分の金額の配列を返すクラスメソッド
  def self.distribute(amount, count)
    base = amount / count
    remains = amount - base * count
    amounts = Array.new(count, base)
    if remains > 0
      selected_index = (0...count).to_a.shuffle.take(remains)
      # 選択されたの金額に余りを追加
      selected_index.each do |sp|
        amounts[sp] += 1
      end
    end
    amounts
  end
end
