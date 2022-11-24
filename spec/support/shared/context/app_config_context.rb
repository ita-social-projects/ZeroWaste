RSpec.shared_context :app_config_load do
  def app_config_load
    config = AppConfig.instance
    config.diapers_calculator = (YAML.load file_fixture('app_config.yml').read)
    config.save
  end

  before { app_config_load }
end
