class ChangeCategories < ActiveRecord::Migration[7.2]
  def change
    remove_columns :categories, :priority, :preferable
    add_column :categories, :price, :float, null: false, default: ""

    add_reference :categories, :field, null: false, foreign_key: true
  end
end
