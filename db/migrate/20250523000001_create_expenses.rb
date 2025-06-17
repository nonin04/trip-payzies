class CreateExpenses < ActiveRecord::Migration[7.2]
  def change
    create_table :expenses do |t|
      t.references :trip, null: false, foreign_key: true
      t.references :payer, null: false, foreign_key: { to_table: :participants }
      t.integer :amount
      t.string :title
      t.date :payment_date
      t.string :place
      t.string :memo

      t.timestamps
    end
  end
end
