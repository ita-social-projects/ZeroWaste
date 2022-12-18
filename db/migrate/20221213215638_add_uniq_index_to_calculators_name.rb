class AddUniqIndexToCalculatorsName < ActiveRecord::Migration[6.1]
  def change
    add_index :calculators, :name, unique: true
  end
end
