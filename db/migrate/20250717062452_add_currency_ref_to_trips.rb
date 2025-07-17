class AddCurrencyRefToTrips < ActiveRecord::Migration[7.2]
  def change
    add_reference :trips, :currency, foreign_key: true
  end
end
