require "rails_helper"

RSpec.describe Account::FeatureFlagsController, type: :request do
  include_context :authorize_admin

  describe "PATCH /account/feature_flags" do
    it "updates access_admin_menu flag and redirects to edit_account_site_setting_path" do
      feature = Flipper[:access_admin_menu]
      feature.disable

      patch account_features_flags_path, params: {
        feature_flags: {
          access_admin_menu_enabled: 1
        }
      }

      expect(feature.enabled?).to eq(true)
      expect(response).to redirect_to(edit_account_site_setting_path)
      expect(flash[:notice]).to eq(I18n.t("notifications.feature_flags_updated"))
    end

    it "updates feature flags and redirects to edit_account_site_setting_path" do
      feature = Flipper[:new_calculator_design]
      feature.disable

      patch account_features_flags_path, params: {
        feature_flags: {
          new_calculator_design_enabled: 1
        }
      }

      expect(feature.enabled?).to eq(true)
      expect(response).to redirect_to(edit_account_site_setting_path)
      expect(flash[:notice]).to eq(I18n.t("notifications.feature_flags_updated"))
    end
  end
end
