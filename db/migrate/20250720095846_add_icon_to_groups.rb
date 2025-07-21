class AddIconToGroups < ActiveRecord::Migration[7.2]
  def change
    add_column :groups, :icon, :string
  end
end
