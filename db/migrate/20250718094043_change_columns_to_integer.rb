class ChangeColumnsToInteger < ActiveRecord::Migration[7.2]
  def change
    change_column :expenses, :amount, :integer
    change_column :advance_payments, :amount, :integer
  end
end
