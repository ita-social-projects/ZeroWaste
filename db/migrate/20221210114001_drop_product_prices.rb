class DropProductPrices < ActiveRecord::Migration[6.1]
  def change
    drop_table :product_prices
  end
end
