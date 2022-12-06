# frozen_string_literal: true

RSpec.shared_context :app_config_load do
  before do
    config = AppConfig.instance
    config.diapers_calculator = YAML.load(file_fixture('app_config.yml').read)
    config.save
  end
end
