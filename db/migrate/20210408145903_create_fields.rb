# frozen_string_literal: true

class CreateFields < ActiveRecord::Migration[6.1]
  def change
    create_table :fields do |t|
      t.uuid :uuid, null: false
      t.references :calculator, null: false
      t.string :selector, null: false
      t.string :type, null: false
      t.string :label, null: false
      t.string :name
      t.string :value
      t.string :unit
      t.integer :from
      t.integer :to
      t.integer :kind, null: false

      t.timestamps
    end
    add_index :fields, :uuid, unique: true
  end
end
