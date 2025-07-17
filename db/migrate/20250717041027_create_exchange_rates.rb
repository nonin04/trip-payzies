class CreateExchangeRates < ActiveRecord::Migration[7.2]
  def change
    create_table :exchange_rates do |t|
      t.references :currency, null: false, foreign_key: true
      t.decimal :rate, precision: 15, scale: 8, null: false
      t.date :rate_date, null: false

      t.timestamps
    end
  end
end
