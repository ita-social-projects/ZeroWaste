if Flipper::Adapters::ActiveRecord::Feature.table_exists?
  require "flipper/adapters/active_record"

  require_relative "flipper_feature"
  require "./app/services/database_backup_service"

  Flipper.configure do |config|
    config.default do
      Flipper.new(Flipper::Adapters::ActiveRecord.new)
    end
  end

  Flipper.features.each do |feature|
    if feature.name == "sandbox_mode" && !DatabaseBackupService.sandbox_enabled?
      Flipper.disable(feature.name)
    else
      Flipper.enable(feature.name)
    end
  end

  # add string below after creating staging environment
  # Flipper.remove(:sandbox_mode) if Rails.env.production?
end
