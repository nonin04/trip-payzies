class AddCurrencyRerToExpenses < ActiveRecord::Migration[7.2]
  def change
    add_reference :expenses, :currency, foreign_key: true
  end
end
