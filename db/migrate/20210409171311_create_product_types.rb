class CreateProductTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :product_types do |t|
      t.uuid :uuid, null: false
      t.string :title

      t.timestamps
    end
    add_index :product_types, :uuid, unique: true
  end
end
