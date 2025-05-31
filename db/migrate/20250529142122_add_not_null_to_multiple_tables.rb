class AddNotNullToMultipleTables < ActiveRecord::Migration[7.2]
  def change
    change_column_null :participants, :name, false
    change_column_null :groups, :name, false
  end
end
