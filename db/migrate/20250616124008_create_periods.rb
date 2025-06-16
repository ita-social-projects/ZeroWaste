class CreatePeriods < ActiveRecord::Migration[7.2]
  def change
    create_table :periods do |t|
      t.integer :period_start
      t.integer :period_end
      t.integer :usage_amount
      t.references :category, null: false, foreign_key: true
      t.decimal :price, precision: 2, scale: 3

      t.timestamps
    end
  end
end
