class AddPreferableToCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :preferable, :string, default: "0", null: false
  end
end
