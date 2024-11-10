class ChangeFields < ActiveRecord::Migration[7.2]
  def up
    change_table :fields, bulk: true do |t|
      t.remove :uuid, type: :string
      t.remove :selector, type: :string
      t.remove :type, type: :string
      t.remove :label, type: :string
      t.remove :name, type: :string
      t.remove :value, type: :integer
      t.remove :from, type: :integer
      t.remove :to, type: :integer
      t.remove :calculator_id, type: :integer

      t.string :uk_label, null: false, default: ""
      t.string :en_label, null: false, default: ""
      t.string :var_name, null: false, default: ""

      t.references :calculator, foreign_key: true, null: false, default: 0
    end

    change_column_default :fields, :calculator_id, from: 0, to: nil
  end

  def down
    change_table :fields, bulk: true do |t|
      t.string :uuid
      t.string :selector
      t.string :type
      t.string :label
      t.string :name
      t.integer :value
      t.integer :from
      t.integer :to
      t.integer :calculator_id

      t.remove :uk_label
      t.remove :en_label
      t.remove :var_name

      t.remove_references :calculator, foreign_key: true
    end
  end
end
