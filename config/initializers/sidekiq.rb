# frozen_string_literal: true

Sidekiq.configure_client do |config|
  config.redis = { size: 1 }
end

Sidekiq.configure_server do |config|
  config.redis = { size: 7 }
end
