# frozen_string_literal: true

require "rails_helper"

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.openapi_root = Rails.root.join("swagger").to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under openapi_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a openapi_spec tag to the
  # the root example_group in your specs, e.g. describe '...', openapi_spec: 'v2/swagger.json'

  production_server = {
    url: "{protocol}://{defaultHostGlobal}/{locale}/api/v2/",
    description: "Production server (uses live data)",
    variables: {
      protocol: {
        default: "https",
        enum: ["http", "https"]
      },
      defaultHostGlobal: {
        default: "calc.zerowastelviv.org.ua"
      },
      locale: {
        default: "en",
        enum: ["en", "uk"]
      }
    }
  }

  development_server = {
    url: "{protocol}://{defaultHostLocal}/{locale}/api/v2/",
    description: "Localhost server (uses test data)",
    variables: {
      protocol: {
        default: "http",
        enum: ["http", "https"]
      },
      defaultHostLocal: {
        default: "127.0.0.1:3000"
      },
      locale: {
        default: "en",
        enum: ["en", "uk"]
      }
    }
  }

  servers = if Rails.env.production?
    [production_server]
  elsif Rails.env.local?
    [development_server, production_server]
  else
    [development_server]
  end

  config.openapi_specs = {
    "v2/swagger.yaml" => {
      openapi: "3.0.1",
      info: {
        title: "API V2",
        version: "v2"
      },
      paths: {},
      servers: servers
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The openapi_specs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.openapi_format = :yaml
end
