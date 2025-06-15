class AddDefaultToAmuontInAdvancePayments < ActiveRecord::Migration[7.2]
  def change
    change_column_default :advance_payments, :amount, from: nil, to: 0
    AdvancePayment.where(amount: nil).update_all(amount: 0)

    change_column_null :advance_payments, :amount, false
  end
end
