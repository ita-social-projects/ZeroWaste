require "rails_helper"

RSpec.describe Account::FeatureFlagsController, type: :request, include_shared: true do
  context "PATCH /account/feature_flags" do
    include_context :authorize_admin
    include_context :disable_admin_menu
    include_context :old_calculator_design

    before do
      patch account_features_flags_path, params: {
        feature_flags: {
          new_calculator_design_enabled: "1",
          access_admin_menu_enabled: "1"
        }
      }
    end

    it "updates access_admin_menu flag and redirects to edit_account_site_setting_path" do
      expect(Flipper[:access_admin_menu].enabled?).to eq(true)
      expect(response).to redirect_to(edit_account_site_setting_path)
      expect(flash[:notice]).to eq(I18n.t("notifications.feature_flags_updated"))
    end

    it "updates feature flags and redirects to edit_account_site_setting_path" do
      expect(Flipper[:new_calculator_design].enabled?).to eq(true)
      expect(response).to redirect_to(edit_account_site_setting_path)
      expect(flash[:notice]).to eq(I18n.t("notifications.feature_flags_updated"))
    end
  end
end
