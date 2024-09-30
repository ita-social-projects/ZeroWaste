# frozen_string_literal: true

require_relative "boot"

require "rails/all"
require "csv"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ZeroWaste
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    config.active_job.queue_adapter = :sidekiq
    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: ["assets", "tasks"])

    config.time_zone = "Kyiv"
    # config.eager_load_paths << Rails.root.join("extras")
    config.i18n.available_locales   = [:en, :uk]
    config.i18n.default_locale      = :en

    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}")]

    config.assets.css_compressor = nil
  end
end
