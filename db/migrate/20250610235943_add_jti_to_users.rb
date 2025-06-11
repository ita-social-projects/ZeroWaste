class AddJtiToUsers < ActiveRecord::Migration[7.2]
  def up
    add_column :users, :jti, :string, null: false
    add_index  :users, :jti, unique: true
    User.find_each { |u| u.update_column :jti, SecureRandom.uuid }
  end

  def down
    remove_column :users, :jti
  end
end
