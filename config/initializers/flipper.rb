require "flipper/adapters/active_record"

Flipper.configure do |config|
  config.default do
    Flipper.new(Flipper::Adapters::ActiveRecord.new)
  end
end

Flipper.features.each do |feature|
  Flipper.enable(feature.name) if Rails.env.development? # || Rails.env.staging?
end
