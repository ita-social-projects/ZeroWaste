class UpdateCalculators < ActiveRecord::Migration[7.2]
  def up
    change_table :calculators, bulk: true do |t|
      t.remove :uuid, :name, :preferable
      t.string :uk_name, null: false, default: ""
      t.string :en_name, null: false, default: ""
    end
  end

  def down
    change_table :calculators, bulk: true do |t|
      t.string :uuid
      t.string :name
      t.boolean :preferable, null: false, default: false

      t.remove :uk_name
      t.remove :en_name
    end
  end
end
