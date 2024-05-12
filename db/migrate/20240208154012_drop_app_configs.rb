class DropAppConfigs < ActiveRecord::Migration[7.1]
  def up
    drop_table :app_configs
  end

  def down
    create_table :app_configs do |t|
      t.jsonb "diapers_calculator", default: {}
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
