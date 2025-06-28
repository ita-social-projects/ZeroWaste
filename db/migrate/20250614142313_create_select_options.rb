class CreateSelectOptions < ActiveRecord::Migration[7.2]
  def change
    create_table :select_options do |t|
      t.references :field, null: false, foreign_key: true
      t.string :key
      t.integer :value

      t.timestamps
    end
  end
end
