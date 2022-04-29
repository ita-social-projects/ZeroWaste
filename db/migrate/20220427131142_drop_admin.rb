class DropAdmin < ActiveRecord::Migration[6.1]
  def change
    drop_table :admins
  end
end
