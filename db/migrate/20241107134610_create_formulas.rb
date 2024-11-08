class CreateFormulas < ActiveRecord::Migration[7.2]
  def change
    create_table :formulas do |t|
      t.string :expression, null: false, default: ""
      t.string :uk_label, null: false, default: ""
      t.string :en_label, null: false
      t.string :uk_unit
      t.string :en_unit
      t.references :calculator, null: false, foreign_key: true

      t.timestamps
    end
  end
end
