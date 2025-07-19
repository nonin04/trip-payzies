class AddDecimalPositionToCurrencies < ActiveRecord::Migration[7.2]
  def change
    add_column :currencies, :decimal_position, :integer, null: false, default: 0
  end
end
