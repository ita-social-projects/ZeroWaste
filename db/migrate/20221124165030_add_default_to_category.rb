class AddDefaultToCategory < ActiveRecord::Migration[7.1]
  def up
    change_column :product_prices, :category, :string, null: false, default: "medium"
  end

  def down
    change_column :product_prices, :category, :string, null: true, default: nil
  end
end
