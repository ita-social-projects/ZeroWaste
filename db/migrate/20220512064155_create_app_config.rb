class CreateAppConfig < ActiveRecord::Migration[6.1]
  def change
    create_table :app_configs do |t|
      t.jsonb :diapers_calculator, default: {}
      t.timestamps
    end
  end
end
