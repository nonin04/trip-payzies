class RemoveCountryFromCurrencies < ActiveRecord::Migration[7.2]
  def change
    remove_column :currencies, :country, :string
  end
end
