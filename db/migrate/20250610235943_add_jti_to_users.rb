class AddJtiToUsers < ActiveRecord::Migration[7.2]
  def up
    add_column :users, :jti, :string
    add_index :users, :jti, unique: true
    User.find_each do |user|
      user.update!(jti: SecureRandom.uuid)
    end
  end

  def down
    remove_column :users, :jti
  end
end
