class Account::UpdateFeatureFlagsService
  def initialize(params)
    @feature_params = params
  end

  def call
    Flipper.features.each do |feature|
      enabled = @feature_params["#{feature.name}_enabled"] == "1"

      if enabled
        Flipper.enable(feature.name)
      else
        Flipper.disable(feature.name)
      end
    end
  end
end
