class AddSymbolToCurrencies < ActiveRecord::Migration[7.2]
  def change
    add_column :currencies, :symbol, :string
  end
end
