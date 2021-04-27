class RemoveUnitFromFields < ActiveRecord::Migration[6.1]
  def change
    remove_column :fields, :unit, :string
  end
end
