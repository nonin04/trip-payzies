class ChangeAmountNotNullInAdvalucePayments < ActiveRecord::Migration[7.2]
  def change
    change_column_null :advance_payments, :amount, false
  end
end
