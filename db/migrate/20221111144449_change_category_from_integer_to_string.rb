class ChangeCategoryFromIntegerToString < ActiveRecord::Migration[6.1]
  def change
    change_column :product_prices, :category, :string
  end
end
