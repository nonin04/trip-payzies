class AddGroupRefToTrips < ActiveRecord::Migration[7.2]
  def change
    add_reference :trips, :group, foreign_key: true
  end
end
