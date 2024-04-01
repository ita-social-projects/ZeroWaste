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
    case feature.name
    when "sandbox_mode"
      Flipper.disable(feature.name) unless DatabaseBackupService.sandbox_enabled?
    when "show_calculators_list"
      Flipper.disable(feature.name)
    else
      Flipper.enable(feature.name)
    end
  end

  # add string below after creating staging environment
  # Flipper.remove(:sandbox_mode) if Rails.env.production?
end
