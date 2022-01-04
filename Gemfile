# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'rails', '~> 6.1.3', '>= 6.1.3.1'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.4'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'friendly_id', '~> 5.4.0'

gem 'dentaku', '~> 3.1'

gem 'country_select', '~> 4.0'

gem 'bigdecimal', '1.3.5'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

gem 'font-awesome-rails'

group :development, :test do
  gem 'pry-rails'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'pronto'
  gem 'pronto-rubocop', require: false
  gem 'spring'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'shoulda-matchers', '~> 4.0'
  gem 'database_cleaner-active_record'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'devise'
gem 'faker'
gem 'slim-rails'
gem 'active_model_serializers', '~> 0.10.0'
gem 'omniauth', '~> 1.9.1'
gem 'omniauth-google-oauth2'
gem 'sidekiq'
gem 'devise-async'
gem 'simple_form'
gem 'cocoon'