class AddValueToFields < ActiveRecord::Migration[7.2]
  def change
    add_column :fields, :value, :decimal, precision: 10, scale: 2
  end
end
