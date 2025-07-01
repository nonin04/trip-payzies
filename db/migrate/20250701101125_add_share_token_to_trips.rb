class AddShareTokenToTrips < ActiveRecord::Migration[7.2]
  def change
    add_column :trips, :share_token, :string
    add_index :trips, :share_token
  end
end
