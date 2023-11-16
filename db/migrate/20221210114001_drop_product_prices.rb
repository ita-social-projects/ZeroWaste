class DropProductPrices < ActiveRecord::Migration[7.1]
  def change
    drop_table :product_prices do |t|
      t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
      t.bigint "product_id", null: false
      t.decimal "price", precision: 8, scale: 2
      t.string "category", default: "medium", null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["product_id"], name: "index_product_prices_on_product_id"
      t.index ["uuid"], name: "index_product_prices_on_uuid", unique: true
    end
  end
end
