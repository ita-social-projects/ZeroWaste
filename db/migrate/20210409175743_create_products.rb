class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.uuid :uuid
      t.string :title
      t.integer :product_type_id

      t.timestamps
    end
  end
end
