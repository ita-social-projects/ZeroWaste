class CreateProductPrices < ActiveRecord::Migration[6.1]
  def change
    create_table :product_prices do |t|
      t.uuid :uuid
      t.float :price
      t.integer :category

      t.timestamps
    end
    add_index :product_prices, :uuid, unique: true
  end
end
