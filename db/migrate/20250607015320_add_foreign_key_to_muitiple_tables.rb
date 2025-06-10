class AddForeignKeyToMuitipleTables < ActiveRecord::Migration[7.2]
  def change
    remove_foreign_key :advance_payments, :expenses
    remove_foreign_key :advance_payments, :participants
    remove_foreign_key :expenses, :participants, column: :payer_id
    remove_foreign_key :expenses, :trips
    remove_foreign_key :groups, :users
    remove_foreign_key :members, :groups
    remove_foreign_key :participants, :trips
    remove_foreign_key :trips, :groups
    remove_foreign_key :trips, :users

    add_foreign_key :expenses, :trips, on_delete: :cascade
    add_foreign_key :expenses, :participants, column: :payer_id, on_delete: :restrict
    add_foreign_key :participants, :trips, on_delete: :cascade
    add_foreign_key :advance_payments, :expenses, on_delete: :cascade
    add_foreign_key :advance_payments, :participants, on_delete: :restrict
    add_foreign_key :trips, :groups, on_delete: :nullify
    add_foreign_key :trips, :users, on_delete: :cascade
    add_foreign_key :groups, :users, on_delete: :cascade
    add_foreign_key :members, :groups, on_delete: :cascade
  end
end
