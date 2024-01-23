class CreateDiapersPeriods < ActiveRecord::Migration[7.1]
  def change
    create_table :diapers_periods do |t|
      t.references :category, null: false, foreign_key: true
      t.decimal :price, precision: 8, scale: 2
      t.integer :period_start, default: 0, null: false
      t.integer :period_end, default: 0, null: false
      t.integer :usage_amount, default: 0, null: false

      t.timestamps
    end
  end
end
