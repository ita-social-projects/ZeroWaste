require 'flipper/adapters/active_record'

Flipper.configure do |config|
  config.default do
    Flipper.new(Flipper::Adapters::ActiveRecord.new)
  end
end

my_feature = Flipper.register(:my_feature) do |actor|
  actor.admin?
end

new_feature = Flipper.register(:new_feature) do |actor|
  actor.admin?
end

then_feature = Flipper.register(:then_feature) do |actor|
  actor.admin?
end
