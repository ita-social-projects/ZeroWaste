class AddBlockedToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :blocked, :boolean
  end
end
