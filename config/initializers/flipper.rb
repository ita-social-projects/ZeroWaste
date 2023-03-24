require "flipper/adapters/active_record"

Flipper.configure do |config|
  config.default do
    Flipper.new(Flipper::Adapters::ActiveRecord.new)
  end
end

Flipper.features.each do |feature|
  if Rails.env.development?
    Flipper.enable(feature.key)
  else
    Flipper.disable(feature.key)
  end
end

class Flipper::Feature
  def description
    feature_record.description
  end

  def description=(value)
    feature_record.update(description: value)
  end

  private

  def feature_record
    Flipper::Adapters::ActiveRecord::Feature.find_or_create_by(key: key)
  end
end

Flipper[:access_admin_menu].description = "This feature flag is responsible for visibility of 'Admin Menu' button on main page"
