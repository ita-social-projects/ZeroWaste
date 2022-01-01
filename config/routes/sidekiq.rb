require "sidekiq/web"

def sha256_digest(value)
  ::Digest::SHA256.hexdigest(value)
end

def secure_compare(string, key)
  sidekiq_web_credentials = Rails.application.secrets.sidekiq
  expected_credential = sidekiq_web_credentials && sidekiq_web_credentials[key]
  return false if [string, expected_credential].any?(&:nil?)

  ActiveSupport::SecurityUtils.secure_compare(
    sha256_digest(string),
    sha256_digest(expected_credential)
  )
end

mount Sidekiq::Web => "/sidekiq"

if %w[staging production].include?(Rails.env)
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    secure_compare(username, :username) & secure_compare(password, :password)
  end
end
