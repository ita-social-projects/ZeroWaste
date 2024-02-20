class AddPreferableToCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :preferable, :integer, default: 0
  end
end
