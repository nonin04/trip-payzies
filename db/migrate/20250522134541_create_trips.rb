class CreateTrips < ActiveRecord::Migration[7.2]
  def change
    create_table :trips do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.integer :settlement_status, null: false, default: 0
      t.date :deperture_date, null: false, default: -> {'CURRENT_DATE'}

      t.timestamps
    end
  end
end
