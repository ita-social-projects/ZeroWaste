class AddProductIdToCalculators < ActiveRecord::Migration[7.1]
  def change
    add_reference :calculators, :product, foreign_key: true
  end
end
