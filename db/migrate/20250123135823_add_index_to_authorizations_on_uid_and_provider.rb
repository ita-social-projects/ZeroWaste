class AddIndexToAuthorizationsOnUidAndProvider < ActiveRecord::Migration[7.2]
  def change
    add_index :authorizations, [:uid, :provider], unique: true
  end
end
