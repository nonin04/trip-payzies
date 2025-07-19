class AddAmountLocalToExpenses < ActiveRecord::Migration[7.2]
  def change
    add_column :expenses, :amount_local, :integer
  end
end
