class AddDefaultToCategory < ActiveRecord::Migration[6.1]
  def change
    change_column :product_prices, :category, :string,null: false, default: 'medium'
  end
end
