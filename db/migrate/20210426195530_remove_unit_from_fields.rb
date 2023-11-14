class RemoveUnitFromFields < ActiveRecord::Migration[7.1]
  def change
    remove_column :fields, :unit, :string
  end
end
