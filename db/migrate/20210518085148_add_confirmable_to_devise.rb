class AddConfirmableToDevise < ActiveRecord::Migration[6.1]
  def change
    change_table(:users) do |t|
      t.column :confirmation_token, :string
      t.column :confirmed_at, :datetime
      t.column ::confirmation_sent_at, :datetime
    end 
  end
end
