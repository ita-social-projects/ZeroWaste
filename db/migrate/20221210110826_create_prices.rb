class CreatePrices < ActiveRecord::Migration[7.1]
  def change
    create_table :prices do |t|
      t.decimal :sum, precision: 8, scale: 2
      t.references :priceable, polymorphic: true
      t.integer :category_id, index: true, null: true

      t.timestamps
    end
  end
end
