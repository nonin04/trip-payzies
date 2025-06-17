class AddUniqueIndexToParticipants < ActiveRecord::Migration[7.2]
  def change
    add_index :participants, [ :trip_id, :name ], unique: true
  end
end
