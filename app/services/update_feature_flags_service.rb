class UpdateFeatureFlagsService
  def initialize(params)
    @feature_params = params
  end

  def call
    Flipper.features.each do |feature|
      feature_name       = feature.name
      is_enabled_new     = @feature_params["#{feature_name}_enabled"].to_s == "1"
      is_enabled_current = Flipper.enabled?(feature_name)

      if is_enabled_new != is_enabled_current
        SandBoxService.enable(is_enabled_new) if feature_name == "sandbox_mode"
        Flipper.public_send((is_enabled_new ? "enable" : "disable").to_s, feature_name)
      end
    end
  end

  def feature_enabled?(feature_name)
    Flipper.enabled?(feature_name)
  end
end
