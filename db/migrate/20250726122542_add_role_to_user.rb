class AddRoleToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :role, :integer, default: 0, null: false

    reversible do |dir|
      dir.up do
        execute "UPDATE users SET role = 0 WHERE role IS NULL"
      end
    end
  end
end
