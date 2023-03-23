class AddDescriptionForFlipperFeatures < ActiveRecord::Migration[6.1]
  def change
    add_column :flipper_features, :description, :string
  end
end
