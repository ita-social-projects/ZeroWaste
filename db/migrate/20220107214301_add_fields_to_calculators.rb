class AddFieldsToCalculators < ActiveRecord::Migration[7.1]
  def change
    add_column :calculators, :preferable, :boolean, default: false
  end
end
