class CreatePrices < ActiveRecord::Migration[6.1]
  def change
    create_table :prices do |t|
      t.decimal :price, precision: 8, scale: 2
      t.references :priceable, polymorphic: true
      t.integer :category_id, null: true

      t.timestamps
    end
  end
end
