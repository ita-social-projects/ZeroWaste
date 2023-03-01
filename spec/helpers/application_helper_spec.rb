require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "#current_site_setting" do
    context "when site setting is invalid" do
      it "should set default values" do
        expect(SiteSetting.instance).not_to be_valid

        expect(current_site_setting.title).to eq("ZeroWaste")
        expect(current_site_setting.favicon).to be_attached
        expect(current_site_setting.favicon.filename).to eq("logo_zerowaste.png")
        expect(current_site_setting.favicon.content_type).to eq("image/png")
      end
    end

    context "when site setting is valid" do
      let(:site_setting_params) { FactoryBot.attributes_for(:site_setting, :with_valid_site_setting) }

      before { SiteSetting.instance.update((site_setting_params)) }

      it "should return the existing site setting" do
        SiteSetting.instance.update((site_setting_params))

        expect(SiteSetting.instance).to be_valid
        expect(current_site_setting.title).to eq("ZeroWaste")
        expect(current_site_setting.favicon).to be_attached
        expect(current_site_setting.favicon.filename).to eq("logo_zerowaste.png")
        expect(current_site_setting.favicon.content_type).to eq("image/png")
      end
    end
  end
end