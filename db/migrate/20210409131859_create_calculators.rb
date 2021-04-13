class CreateCalculators < ActiveRecord::Migration[6.1]
  def change
    create_table :calculators do |t|
      t.uuid :uuid, null: false
      t.string :name

      t.timestamps
    end
    add_index :calculators, :uuid, unique: true
  end
end
