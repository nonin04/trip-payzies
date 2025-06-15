class ChangeAmountNullInAdvancePayments < ActiveRecord::Migration[7.2]
  def change
    change_column_null :advance_payments, :amount, true
  end
end
