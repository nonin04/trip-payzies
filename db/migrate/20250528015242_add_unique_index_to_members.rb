class AddUniqueIndexToMembers < ActiveRecord::Migration[7.2]
  def change
    add_index :members, [ :group_id, :name ], unique: true
  end
end
