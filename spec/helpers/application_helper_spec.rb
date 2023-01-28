require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "#current_site_setting" do
    context "when site setting is invalid" do
      it "should set default values" do
        expect(SiteSetting.instance).not_to be_valid

        current_site_setting = helper.current_site_setting

        expect(current_site_setting.title).to eq("ZeroWaste")
        expect(current_site_setting.favicon).to be_attached
        expect(current_site_setting.favicon.filename).to eq("logo_zerowaste.png")
        expect(current_site_setting.favicon.content_type).to eq("image/png")
      end
    end

    context "when site setting is valid" do
      before do
        file = Tempfile.new(["test_image", ".png"], content_type: "image/png")

        @blob = ActiveStorage::Blob.create_and_upload!(io: file, filename: "test_image.png")

        file.close
        file.unlink
      end

      it "should return the existing site setting" do
        SiteSetting.instance.update(title: "My Title", favicon: @blob)

        expect(SiteSetting.instance).to be_valid

        current_site_setting = helper.current_site_setting

        expect(current_site_setting.title).to eq("My Title")
        expect(current_site_setting.favicon).to be_attached
        expect(current_site_setting.favicon.filename).to eq("test_image.png")
        expect(current_site_setting.favicon.content_type).to eq("image/png")
      end
    end
  end
end
