# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.2"

gem "cancancan", "~> 3.3"
gem "jbuilder", "~> 2.7"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rails", "~> 6.1.3", ">= 6.1.3.1"
gem "redis", "~> 4.0"
gem "sass-rails", ">= 6"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 5.4"
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem "acts_as_singleton"
gem "friendly_id", "~> 5.4.0"

gem "dentaku", "~> 3.1"
gem "it"

gem "country_select", "~> 4.0"

gem "bigdecimal", "1.3.5"
gem "rails-i18n", "~> 7.0.0"

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.4", require: false

gem "active_storage_validations"
gem "font-awesome-rails"
gem "mini_magick", ">= 4.9.5"

group :development, :test do
  gem "annotate"
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "pry-rails"
  gem "rails-controller-testing"
  gem "rspec-rails", "~> 5.0.0"
end

group :development, :test, :ci do
  # Code linters
  gem "rubocop", "~> 1.39", require: false
  gem "rubocop-rspec", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "standard", "~> 1.0", require: false
end

group :development do
  gem "letter_opener"
  gem "listen", "~> 3.3"
  gem "pronto"
  # gem 'pronto-rubocop', require: false
  gem "rack-mini-profiler", "~> 2.0"
  gem "spring"
  gem "web-console", ">= 4.1.0"
end

# group :ci do
#   gem 'rubocop', require: false
# end

group :test do
  gem "capybara", ">= 3.26"
  gem "codecov", require: false
  gem "database_cleaner-active_record"
  gem "selenium-webdriver"
  gem "simplecov", require: false
  gem "shoulda-matchers", "~> 4.0"
  gem "webdrivers"
  gem "fuubar"
end

gem "active_model_serializers", "~> 0.10.0"
gem "any_login"
gem "cocoon"
gem "devise"
gem "devise-async"
gem "faker"
gem "omniauth", "~> 1.9.1"
gem "omniauth-facebook"
gem "omniauth-google-oauth2"
gem "paper_trail"
gem "sidekiq"
gem "simple_form"
gem "slim-rails"
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
