require "flipper/adapters/active_record"

Flipper.configure do |config|
  config.default do
    Flipper.new(Flipper::Adapters::ActiveRecord.new)
  end
end

Flipper.features.each do |feature|
  if Rails.env.development?
    Flipper.enable(feature.name)
  else
    Flipper.disable(feature.name)
  end
end

class Flipper::Feature
  delegate :description, :description=, to: :feature_record
  alias_method :key, :name

  private

  def feature_record
    @feature_record ||= Flipper::Adapters::ActiveRecord::Feature.find_or_create_by(key: key)
  end
end

Flipper[:access_admin_menu].enable
Flipper[:access_admin_menu].description = "This feature flag is responsible for visibility of 'Admin Menu' button on main page"
