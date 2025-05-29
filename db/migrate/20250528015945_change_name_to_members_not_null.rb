class ChangeNameToMembersNotNull < ActiveRecord::Migration[7.2]
  def change
    change_column_null :members, :name, false
  end
end
