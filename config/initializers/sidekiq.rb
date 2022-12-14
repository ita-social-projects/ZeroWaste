# frozen_string_literal: true

require 'sidekiq/web'

Sidekiq.configure_client do |config|
  config.redis = { size: 1, url: ENV.fetch('REDIS_URL', nil),
                   namespace: ENV.fetch('SIDEKIQ_NAMESPACE', nil) }
end

Sidekiq.configure_server do |config|
  config.redis = { size: 7, url: ENV.fetch('REDIS_URL', nil),
                   namespace: ENV.fetch('SIDEKIQ_NAMESPACE', nil) }
end

Sidekiq::Web.use(Rack::Auth::Basic) do |username, password|
  username == ENV['SIDEKIQ_USERNAME'] &&
    password == ENV['SIDEKIQ_PASSWORD']
end
