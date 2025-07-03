require_relative "boot"

require "rails/all"

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
    #
    # Add to stop any css compressor
    config.assets.css_compressor = nil
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.middleware.use Rack::Attack

    config.time_zone = "Kyiv"
    # config.eager_load_paths << Rails.root.join("extras")
    config.i18n.available_locales   = [:en, :uk]
    config.i18n.default_locale      = :en

    config.i18n.load_path += Rails.root.glob("config/locales/**/*.{rb,yml}")
  end
end
