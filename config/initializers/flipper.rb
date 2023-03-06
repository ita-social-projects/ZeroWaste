require "flipper/adapters/active_record"

Flipper.configure do |config|
  config.default do
    Flipper.new(Flipper::Adapters::ActiveRecord.new)
  end
end

Flipper.register(:my_feature) do |actor|
  actor.admin?
end

Flipper.register(:new_feature) do |actor|
  actor.admin?
end

Flipper.register(:then_feature) do |actor|
  actor.admin?
end
