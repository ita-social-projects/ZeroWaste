class CreateDiapersPeriods < ActiveRecord::Migration[7.1]
  def change
    create_table :diapers_periods do |t|
      t.references :category, null: false, foreign_key: true
      t.decimal :price, precision: 8, scale: 2, null: false
      t.integer :period_start, null: false
      t.integer :period_end, null: false
      t.integer :usage_amount, null: false

      t.timestamps
    end
  end
end
