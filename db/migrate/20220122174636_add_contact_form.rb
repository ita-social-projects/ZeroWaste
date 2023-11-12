class AddContactForm < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.string :title, null: false
      t.string :message, null: false
      t.string :email, null: false

      t.timestamps
    end
  end
end
