class CreateAuthorization < ActiveRecord::Migration[7.2]
  def change
    create_table :authorizations do |t|
      t.string :uid
      t.string :provider
      t.references :user, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
