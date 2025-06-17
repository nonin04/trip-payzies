class AddUniqueIndexToAdvancePayments < ActiveRecord::Migration[7.2]
  def change
    add_index :advance_payments, [ :expense_id, :participant_id ], unique: true
  end
end
