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
    include_context :update_site_setting

    let!(:site_setting) { SiteSetting.instance }
    let(:site_setting_params) { FactoryBot.attributes_for(:site_setting, :with_favicon) }

    it "has a valid factory" do
      expect(site_setting).to be_valid
    end

    it "is valid with valid attributes" do
      expect(site_setting).to be_valid
    end

    it "is not valid without a title" do
      site_setting.title = nil
      expect(site_setting).not_to be_valid
    end

    it "is not valid with a title longer than 20 characters" do
      site_setting.title = "a" * 21
      expect(site_setting).not_to be_valid
    end

    it "is not valid without a favicon" do
      site_setting.favicon.purge
      expect(site_setting).not_to be_valid
    end

    it "is not valid with a favicon of invalid type" do
      site_setting.favicon.content_type = "application/pdf"
      expect(site_setting).not_to be_valid
    end

    it "is valid with a favicon of valid type" do
      site_setting.favicon.content_type = "image/png"
      expect(site_setting).to be_valid
    end

    it "is not valid with a favicon larger than 500 KB" do
      site_setting.favicon.byte_size = 600.kilobytes
      expect(site_setting).not_to be_valid
      expect(site_setting.errors.messages[:favicon]).to include(I18n.t("account.site_settings.validations.size"))
    end
  end
end
