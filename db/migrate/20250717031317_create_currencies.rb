class CreateCurrencies < ActiveRecord::Migration[7.2]
  def change
    create_table :currencies do |t|
      t.string :country, null: false
      t.string :code, null: false
      t.string :ja_name, null: false
      t.string :en_name, null: false

      t.timestamps
    end
  end
end
