# 立替対象者の負担額(あまりの分配含む)を計算
class ExpenseAmountSplitter
  def self.distribute(amount, count)
    base = amount / count
    remains = amount - base * count
    amounts = Array.new(count, base)
    if remains > 0
      selected_index = (0...count).to_a.shuffle.take(remains)
      selected_index.each do |sp|
        amounts[sp] += 1
      end
    end
    amounts
  end
end
