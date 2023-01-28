require "rails_helper"

def create_valid_file
  file = Tempfile.new(["valid_file", ".png"], content_type: "image/png")
  file.truncate(500.kilobytes - 1)

  blob = ActiveStorage::Blob.create_and_upload!(io: file, filename: "valid_file.png")

  file.close
  file.unlink

  blob
end

def create_invalid_file
  file = Tempfile.new(["invalid_file", ".pdf"], content_type: "application/pdf")
  file.truncate(500.kilobytes - 1)

  blob = ActiveStorage::Blob.create_and_upload!(io: file, filename: "invalid_file.pdf")

  file.close
  file.unlink

  blob
end

def create_big_file
  file = Tempfile.new(["big_file", ".jpg"], content_type: "image/jpg")
  file.truncate(500.kilobytes + 1)

  blob = ActiveStorage::Blob.create_and_upload!(io: file, filename: "big_file.jpg")

  file.close
  file.unlink

  blob
end

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
    let!(:site_setting) { SiteSetting.instance }

    it "has a valid factory" do
      site_setting.update(title: "Test Title", favicon: create_valid_file)

      expect(site_setting).to be_valid
    end

    it "is valid with valid attributes" do
      site_setting.update(title: "Test Title", favicon: create_valid_file)

      expect(site_setting).to be_valid
    end

    it "is not valid without a title" do
      site_setting.update(favicon: create_valid_file)

      expect(site_setting).not_to be_valid
    end

    it "is not valid with a title longer than 20 characters" do
      site_setting.update(title: "a" * 21, favicon: create_valid_file)

      expect(site_setting).not_to be_valid
    end

    it "is not valid without a favicon" do
      site_setting.update(title: "Test Title")
      site_setting.favicon.purge

      expect(site_setting).not_to be_valid
    end

    it "is not valid with a favicon of invalid type" do
      site_setting.update(title: "Test Title", favicon: create_invalid_file)

      expect(site_setting).not_to be_valid
    end

    it "is valid with a favicon of valid type" do
      site_setting.update(title: "Test Title", favicon: create_valid_file)

      expect(site_setting).to be_valid
    end

    it "is not valid with a favicon larger than 500 KB" do
      site_setting.update(title: "Test Title", favicon: create_big_file)

      expect(site_setting).not_to be_valid
      expect(site_setting.errors.messages[:favicon]).to include(I18n.t("account.site_settings.validations.size"))
    end
  end
end
