class RemoveFlipperTables < ActiveRecord::Migration[6.1]
  def change
    drop_table :flipper_features
    drop_table :flipper_gates
  end
end
