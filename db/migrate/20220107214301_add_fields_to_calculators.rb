class AddFieldsToCalculators < ActiveRecord::Migration[6.1]
  def change
    add_column :calculators, :preferable, :boolean, default: false
  end
end
