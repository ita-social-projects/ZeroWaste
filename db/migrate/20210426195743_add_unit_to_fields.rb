class AddUnitToFields < ActiveRecord::Migration[6.1]
  def change
    add_column :fields, :unit, :integer, default: 0
  end
end
