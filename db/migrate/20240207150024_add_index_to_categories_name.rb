class AddIndexToCategoriesName < ActiveRecord::Migration[7.1]
  def change
    add_index :categories, "LOWER(name)", name: "index_categories_on_name", unique: true
  end
end
