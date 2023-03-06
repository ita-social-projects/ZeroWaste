class Account::FeatureFlagsController < Account::BaseController
  def index
  end

  def show
  end

  def update
    Flipper.features.each do |feature|
      # Get the current state of the feature from the form
      enabled = params["#{feature.key}_enabled"] == "1"

      # Enable or disable the feature based on the form input
      if enabled
        Flipper.enable(feature.key)
      else
        Flipper.disable(feature.key)
      end
    end

    redirect_to account_feature_flags_path, notice: t("notifications.category_updated")
  end
end
