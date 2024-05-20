class AddEnNameAndRenameNameToUkNameInCategories < ActiveRecord::Migration[7.1]
  def up
    remove_index :categories, name: "index_categories_on_name"
    rename_column :categories, :name, :uk_name
    add_index :categories, "lower((uk_name)::text)", name: "index_categories_on_uk_name", unique: true
    add_column :categories, :en_name, :string
    add_index :categories, "lower((en_name)::text)", name: "index_categories_on_en_name", unique: true
  end

  def down
    remove_index :categories, name: "index_categories_on_uk_name"
    rename_column :categories, :uk_name, :name
    add_index :categories, "lower((name)::text)", name: "index_categories_on_name", unique: true
    remove_index :categories, name: "index_categories_on_en_name"
    remove_column :categories, :en_name
  end
end
