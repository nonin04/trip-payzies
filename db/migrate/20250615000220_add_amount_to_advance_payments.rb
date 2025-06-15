class AddAmountToAdvancePayments < ActiveRecord::Migration[7.2]
  def change
    add_column :advance_payments, :amount, :integer
  end
end
