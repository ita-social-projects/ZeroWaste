class AddProductIdToCalculators < ActiveRecord::Migration[6.1]
  def change
    add_column :calculators, :product_id, :integer
  end
end
