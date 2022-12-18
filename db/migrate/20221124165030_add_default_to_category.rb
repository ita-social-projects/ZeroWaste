class AddDefaultToCategory < ActiveRecord::Migration[6.1]
  def up
    change_table :product_prices, bulk: true do |t|
      t.string :category, null: false, default: "medium"
    end
  end

  def down
    change_table :product_prices, bulk: true do |t|
      t.string :category
    end
  end
end
