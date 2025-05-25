class CreateAdvancePayments < ActiveRecord::Migration[7.2]
  def change
    create_table :advance_payments do |t|
      t.references :expense, null: false, foreign_key: true
      t.references :participant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
