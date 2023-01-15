require "rails_helper"

RSpec.describe SiteSetting, type: :model do
  context "is a singleton model" do
    it "should not allow using new method" do
      expect { SiteSetting.new }.to raise_error NoMethodError
    end

    it "should have instance method" do
      expect(SiteSetting.instance).to be_an SiteSetting
    end
  end

  context "validates properly" do
    before do
      @file = Tempfile.new(["test_image", ".jpg"], content_type: "image/jpg")
      @file.write("Test file contents")
      @file.rewind

      @blob = ActiveStorage::Blob.create_and_upload!(io: @file, filename: "test_image.jpg")

      @original_site_setting = SiteSetting.instance
      @site_setting          = SiteSetting.instance
    end

    after do
      @file.close
      @file.unlink

      SiteSetting.instance.update(@original_site_setting.attributes)
    end

    it "has a valid factory" do
      @site_setting.update(title: "Test Title", favicon: @blob)

      expect(@site_setting).to be_valid
    end

    it "is valid with valid attributes" do
      @site_setting.update(title: "Test Title", favicon: @blob)

      expect(@site_setting.valid?).to be_truthy
    end

    it "is not valid without a title" do
      @site_setting.update(favicon: @blob)

      expect(@site_setting.valid?).to be_falsey
    end

    it "is not valid with a title longer than 20 characters" do
      @site_setting.update(title: "a" * 21, favicon: @blob)

      expect(@site_setting.valid?).to be_falsey
    end

    it "is not valid without a favicon" do
      @site_setting.update(title: "Test Title")
      @site_setting.favicon.purge

      expect(@site_setting.valid?).to be_falsey
    end
  end
end
