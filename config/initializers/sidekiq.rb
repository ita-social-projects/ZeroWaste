# frozen_string_literal: true
require 'sidekiq/web'

Sidekiq.configure_client do |config|
  config.redis = { size: 1, url: ENV['REDIS_URL'], namespace: ENV['SIDEKIQ_NAMESPACE'] }
end

Sidekiq.configure_server do |config|
  config.redis = { size: 7, url: ENV['REDIS_URL'], namespace: ENV['SIDEKIQ_NAMESPACE'] }
end

Sidekiq::Web.use(Rack::Auth::Basic) do |username, password|
  username == ENV['SIDEKIQ_USERNAME'] &&
    password == ENV['SIDEKIQ_PASSWORD']
end
