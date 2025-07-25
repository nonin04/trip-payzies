class ExpenseAmountDistributor
  def initialize(expense)
    @expense = expense
  end

  def call
    advance_payments = @expense.advance_payments.to_a
    total_amount = @expense.amount
    count = advance_payments.count
    # 総額が対象者より少ないときはreturn
    if total_amount < count
      return
    end

    # 一人あたりの額(均等分け)
    base_amount = total_amount / count
    # 残り
    remains_amount = total_amount - base_amount * count

    # 均等分けした額を対象者のamountに追加
    advance_payments.each do |ap|
      ap.amount = base_amount
    end

    if remains_amount > 0
    # 対象者からランダムで余りの負担者を選択[配列]
    selected_participant_index = (0...count).to_a.shuffle.take(remains_amount)

      # 選択された負担者のamountに余りを追加
      selected_participant_index.each do |sp|
        advance_payments[sp].amount += 1
      end
    end


    advance_payments.each do |ap|
      ap.save!
    end
  end
end
