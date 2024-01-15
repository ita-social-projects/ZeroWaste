class CreateDiaperUsages < ActiveRecord::Migration[7.1]
  def change
    create_table :diaper_usages do |t|
      t.integer :quantity_per_day, limit: 4, default: 0, null: false
      t.references :life_period, null: false, foreign_key: true

      t.timestamps
    end
  end
end
