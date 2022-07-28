class CreateProductPrices < ActiveRecord::Migration[6.1]
  def change
    create_table :product_prices do |t|
      t.references :product, null: false, foreign_key: true
      t.uuid :uuid
      t.float :price
      t.integer :category

      t.timestamps
    end
    add_index :product_prices, :uuid, unique: true
  end
end
