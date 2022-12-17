class ChangeCategoryFromIntegerToString < ActiveRecord::Migration[6.1]
  def up
    change_column :product_prices, :category, :string
  end

  def down
    change_column :product_prices, :category, :integer
  end
end
