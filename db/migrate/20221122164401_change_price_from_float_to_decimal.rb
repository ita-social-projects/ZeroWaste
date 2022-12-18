class ChangePriceFromFloatToDecimal < ActiveRecord::Migration[6.1]
  def up
    change_column :product_prices, :price, :decimal, precision: 8, scale: 2
  end

  def down
    change_column :product_prices, :price, :float
  end
end
