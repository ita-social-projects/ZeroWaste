class AddPriorityToFormulas < ActiveRecord::Migration[7.2]
  def change
    add_column :formulas, :priority, :integer, default: 0, null: false
  end
end
