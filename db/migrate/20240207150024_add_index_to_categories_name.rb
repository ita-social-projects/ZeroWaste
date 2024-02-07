class AddIndexToCategoriesName < ActiveRecord::Migration[7.1]
  def change
    add_index :categories, :name, unique: true, name: "index_categories_on_name"
  end
end
