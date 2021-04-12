class AddUuidcheckingToProducts < ActiveRecord::Migration[6.1]
  def change
    change_column_null :products, :uuid, false
  end
end
