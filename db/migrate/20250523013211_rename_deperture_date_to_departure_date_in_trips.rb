class RenameDepertureDateToDepartureDateInTrips < ActiveRecord::Migration[7.2]
  def change
    rename_column :trips, :deperture_date, :departure_date
  end
end
