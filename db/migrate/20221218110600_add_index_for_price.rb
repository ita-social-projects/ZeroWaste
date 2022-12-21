class AddIndexForPrice < ActiveRecord::Migration[6.1]
  def change
    add_index :prices, [:category_id, :priceable_id, :priceable_type], unique: true
  end
end
