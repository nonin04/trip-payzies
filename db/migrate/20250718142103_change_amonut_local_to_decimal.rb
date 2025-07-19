class ChangeAmonutLocalToDecimal < ActiveRecord::Migration[7.2]
  def change
        change_column :expenses, :amount_local, :decimal, precision: 15, scale: 2
  end
end
