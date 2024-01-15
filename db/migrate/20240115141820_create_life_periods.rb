class CreateLifePeriods < ActiveRecord::Migration[7.1]
  def change
    create_table :life_periods do |t|
      t.string :name, null: false
      t.jsonb :month_range, null: false, default: "[]"

      t.timestamps
    end
  end
end
