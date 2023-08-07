require "rails_helper"

RSpec.describe "Feature Flags", type: :feature do
  include_context :authorize_admin
  let(:feature) { Flipper[:access_admin_menu] }

  context "when feature is enable" do
    before do
      feature.enable
    end

    it "displays the admin tab when the access_admin_menu feature flag is enabled" do
      visit root_path

      expect(page).to have_content("Admin")
    end
  end

  context "when feature is disable" do
    before do
      feature.disable
    end

    it "does not display the admin tab when the access_admin_menu feature flag is disabled" do
      visit root_path

      expect(page).not_to have_content("Admin")
    end
  end
end
