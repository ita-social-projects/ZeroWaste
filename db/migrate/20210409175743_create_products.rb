class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.uuid :uuid
      t.string :title
      t.references :product_type

      t.timestamps
    end
    add_index :products, :uuid, unique: true
  end
end
