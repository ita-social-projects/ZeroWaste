require "rails_helper"

RSpec.describe Account::FeatureFlagsController, type: :request do
  include_context :authorize_admin

  describe "PATCH /account/feature_flags", skip: true do
    it "updates feature flags and redirects to edit_account_site_setting_path" do
      feature = Flipper[:access_admin_menu]
      feature.disable

      patch account_features_flags_path, params: {
        access_admin_menu_enabled: 1
      }

      expect(feature.enabled?).to eq(true)
      expect(response).to redirect_to(edit_account_site_setting_path)
      expect(flash[:notice]).to eq(I18n.t("notifications.feature_flags_updated"))
    end
  end
end
