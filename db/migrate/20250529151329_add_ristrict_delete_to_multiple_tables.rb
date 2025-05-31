class AddRistrictDeleteToMultipleTables < ActiveRecord::Migration[7.2]
  def change
    remove_foreign_key :expenses, column: :payer_id
    remove_foreign_key :advance_payments, :participants

    add_foreign_key :expenses, :participants, column: :payer_id, on_delete: :restrict
    add_foreign_key :advance_payments, :participants, on_delete: :restrict
  end
end
