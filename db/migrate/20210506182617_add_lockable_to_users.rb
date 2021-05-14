class AddLockableToUsers < ActiveRecord::Migration[6.1]
  def change
    change_table(:users) do |t|
      t.column :failed_attempts, :integer, default: 0
      t.column :unlock_token, :string
      t.column :locked_at, :datetime
    end 
  end
end
