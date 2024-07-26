# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.3"

gem "mutex_m", "0.1.2"
gem "cancancan", "~> 3.3"
gem "jbuilder", "~> 2.7"
gem "kaminari"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rails", "~> 7.1", ">= 7.1.2"
gem "redis", "~> 4.0"
gem "sass-rails", ">= 6"
gem "hotwire-rails"
gem "importmap-rails", "~> 1.1"
gem "bootstrap"
gem "jquery-rails"
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem "acts_as_singleton"
gem "friendly_id", "~> 5.4.0"
gem "babosa"

gem "dentaku", "~> 3.1"
gem "it"

gem "rugged", "1.6.3"

gem "net-smtp"

gem "country_select"

gem "bigdecimal", "3.0.2"
gem "rails-i18n", "~> 7.0.0"

# Use Active Storage variant
gem "image_processing", "~> 1.2"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.4", require: false
gem "tailwindcss-rails", "~> 2.0"

gem "active_storage_validations"
gem "font-awesome-sass", "~> 6.4"
gem "mini_magick", ">= 4.9.5"
gem "factory_bot_rails" # TODO: create ENV staging and use it for this

group :development, :test do
  gem "annotate"
  gem "dotenv-rails", require: "dotenv/rails-now"
  gem "pry-rails"
  gem "rails-controller-testing"
  gem "rspec-rails"
end

group :development, :test, :ci do
  # Code linters
  gem "rubocop", "~> 1.39", require: false
  gem "rubocop-rspec", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-factory_bot", require: false
  gem "rubocop-capybara", require: false
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
  # deploy
  gem "capistrano", "~> 3.11"
  gem "capistrano-rails", "~> 1.4"
  gem "capistrano-passenger", "~> 0.2.0"
  gem "capistrano-rbenv", "~> 2.1", ">= 2.1.4"
  gem "capistrano-yarn"
  gem "capistrano-rails-tail-log"
  gem "ed25519"
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
  gem "shoulda-matchers"
  gem "webdrivers", "~> 5.3.1"
  gem "fuubar"
end

gem "active_model_serializers", "~> 0.10.0"
gem "any_login"
gem "devise"
gem "devise-async"
gem "faker"
gem "omniauth", "~> 1.9.1"
gem "omniauth-facebook"
gem "omniauth-google-oauth2"
gem "paper_trail", "~> 15.0"
gem "sidekiq"
gem "simple_form"
gem "slim-rails"
gem "stimulus-rails"
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "requestjs-rails"
gem "flipper"
gem "flipper-active_record"
gem "ransack"
gem "rails_db", "~> 2.4"
gem "meta-tags"
gem "inline_svg"
gem "net-pop", require: false
