class AddUnitToFields < ActiveRecord::Migration[7.1]
  def change
    add_column :fields, :unit, :integer, default: 0
  end
end
