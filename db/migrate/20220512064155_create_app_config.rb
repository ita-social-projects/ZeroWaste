class CreateAppConfig < ActiveRecord::Migration[6.1]
  def change
    create_table :app_configs do |t|
      t.integer :singleton_guard, default: 0
      t.jsonb :diapers_calculator, default: {}
      t.timestamps
    end
    add_index(:app_configs, :singleton_guard, :unique => true)
  end
end
