class AddPreferableToCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :preferable, :boolean, default: false
  end
end
