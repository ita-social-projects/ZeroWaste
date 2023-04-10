require "flipper/adapters/active_record"
require_relative "flipper_feature"

Flipper.configure do |config|
  config.default do
    Flipper.new(Flipper::Adapters::ActiveRecord.new)
  end
end
