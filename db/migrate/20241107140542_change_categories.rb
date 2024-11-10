class ChangeCategories < ActiveRecord::Migration[7.2]
  def up
    change_table :categories, bulk: true do |t|
      t.remove :preferable, type: :boolean

      t.float :price, null: false, default: 0.0

      t.references :field, null: false, foreign_key: true, default: 0

      t.boolean :preferable, null: false, default: false
    end

    change_column_default :categories, :field_id, nil
  end

  def down
    change_table :categories, bulk: true do |t|
      t.remove :preferable, type: :boolean

      t.remove :pricet.remove_references :field, foreign_key: true
    end
  end
end
