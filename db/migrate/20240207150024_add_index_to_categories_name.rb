class AddIndexToCategoriesName < ActiveRecord::Migration[7.1]
  def change
    add_index :categories, :name, unique: true
  end
end
