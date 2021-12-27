# frozen_string_literal: true

Sidekiq.configure_client do |config|
  config.redis = { size: 1, url: ENV['REDIS_URL'], namespace: ENV['SIDEKIQ_NAMESPACE'] }
end

Sidekiq.configure_server do |config|
  config.redis = { size: 7, url: ENV['REDIS_URL'], namespace: ENV['SIDEKIQ_NAMESPACE'] }
end
