# 対象者の負担額をadvance_paymentに保存するクラス
class ExpenseAmountApplier
  def initialize(expense)
    @expense = expense
  end

  def call
    advance_payments = @expense.advance_payments.to_a
    count = advance_payments.count
    each_amount = ExpenseAmountSplitter.distribute(@expense.amount, advance_payments.size)
    Expense.transaction do
      advance_payments.each_with_index do |ap, i|
        ap.amount = each_amount[i]
        ap.save!
      end
    end
  end
end
