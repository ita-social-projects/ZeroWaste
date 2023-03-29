require "flipper/adapters/active_record"

Flipper.configure do |config|
  config.default do
    Flipper.new(Flipper::Adapters::ActiveRecord.new)
  end
end

Flipper.features.each do |feature|
  Flipper.enable(feature.name) if Rails.env.development? || Rails.env.staging?
end

class Flipper::Feature
  alias_method :name, :key

  def description
    @description ||= feature_record.description
  end

  def description=(value)
    feature_record.update(description: value)

    @description = value
  end

  private

  def feature_record
    @feature_record ||= Flipper::Adapters::ActiveRecord::Feature.find_or_create_by(key: key)
  end
end
Flipper[:access_admin_menu].enable
Flipper[:access_admin_menu].description = "This feature flag is responsible for visibility of 'Admin Menu' button on main page"
