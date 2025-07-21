class ChangeCategories < ActiveRecord::Migration[7.2]
  def up
    change_table :categories, bulk: true do |t|
      t.remove :preferable, type: :boolean

      t.decimal :price, precision: 10, scale: 2, null: false, default: 0.0

      t.references :field, foreign_key: true

      t.boolean :preferable, null: false, default: false
    end

    remove_index :categories, name: "index_categories_on_en_name"
    remove_index :categories, name: "index_categories_on_uk_name"
    change_column_default :categories, :field_id, nil
  end

  def down
    change_table :categories, bulk: true do |t|
      t.remove :preferable, type: :boolean

      t.remove :price
      t.remove_references :field, foreign_key: true
    end

    add_index :categories, "lower((uk_name)::text)", name: "index_categories_on_uk_name", unique: true
    add_index :categories, "lower((en_name)::text)", name: "index_categories_on_en_name", unique: true
  end
end
