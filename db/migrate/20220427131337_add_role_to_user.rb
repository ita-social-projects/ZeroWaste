class AddRoleToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :role, :integer, default: 0
  end
end
