class ChangeColumnOnExpenses < ActiveRecord::Migration[7.2]
  def change
    change_column_default :expenses, :payment_date, -> { 'CURRENT_DATE' }
    change_column_null :expenses, :title, false
    change_column_null :expenses, :amount, false
    change_column_null :expenses, :payment_date, false
  end
end
