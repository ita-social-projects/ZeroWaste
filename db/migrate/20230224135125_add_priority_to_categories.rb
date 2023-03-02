class AddPriorityToCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :priority, :integer, default: 0, null: false
  end
end
