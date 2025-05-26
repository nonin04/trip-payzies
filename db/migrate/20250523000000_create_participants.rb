class CreateParticipants < ActiveRecord::Migration[7.2]
  def change
    create_table :participants do |t|
      t.references :trip, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
