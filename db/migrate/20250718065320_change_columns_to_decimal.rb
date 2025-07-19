class ChangeColumnsToDecimal < ActiveRecord::Migration[7.2]
  def change
    change_column :expenses, :amount, :decimal, precision: 15, scale: 2
    change_column :advance_payments, :amount, :decimal, precision: 15, scale: 2
  end
end
