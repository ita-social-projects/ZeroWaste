class AddProductIdToCalculators < ActiveRecord::Migration[6.1]
  def change
    add_reference :calculators, :product
  end
end
