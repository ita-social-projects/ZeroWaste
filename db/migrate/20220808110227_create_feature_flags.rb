class CreateFeatureFlags < ActiveRecord::Migration[6.1]
  def change
    create_table :feature_flags do |t|
      t.string :name, null: false, index: { unique: true }
      t.boolean :enabled, default: false, null: false

      t.timestamps
    end
  end
end
