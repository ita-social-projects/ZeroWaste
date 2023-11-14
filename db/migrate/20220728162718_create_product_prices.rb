class CreateProductPrices < ActiveRecord::Migration[7.1]
  def change
    create_table :product_prices do |t|
      t.uuid :uuid, default: -> { "gen_random_uuid()" }, null: false
      t.references :product, null: false
      t.float :price
      t.integer :category

      t.timestamps
    end
    add_index :product_prices, :uuid, unique: true
  end
end
