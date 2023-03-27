require "rails_helper"

RSpec.describe Account::UpdateFeatureFlagsService do
  let(:access_admin_menu_feature) { Flipper[:access_admin_menu] }

  describe "#call" do
    context "when access_admin_menu is enabled" do
      it "disables access_admin_menu feature" do
        access_admin_menu_feature.enable
        expect(Flipper).to receive(:features).and_return([access_admin_menu_feature])

        params = { "#{access_admin_menu_feature.name}_enabled" => "0" }
        service = Account::UpdateFeatureFlagsService.new(params)

        expect(access_admin_menu_feature).to receive(:disable)

        service.call
      end
    end

    context "when access_admin_menu is disabled" do
      it "enables access_admin_menu feature" do
        access_admin_menu_feature.disable

        expect(Flipper).to receive(:features).and_return([access_admin_menu_feature])

        params = { "#{access_admin_menu_feature.name}_enabled" => "1" }
        service = Account::UpdateFeatureFlagsService.new(params)

        expect(access_admin_menu_feature).to receive(:enable)

        service.call
      end
    end
  end
end
