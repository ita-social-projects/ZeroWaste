require "rails_helper"

RSpec.describe SiteSetting, type: :model do
  context "is a singleton model" do
    it "should not allow using new method" do
      expect { SiteSetting.new }.to raise_error NoMethodError
    end

    it "should have current method" do
      expect(SiteSetting.current).to be_persisted
    end
  end

  context "validates properly" do
    before { subject.update(site_setting_params) }

    let!(:subject) { SiteSetting.current }
    let(:site_setting_params) { FactoryBot.attributes_for(:site_setting, :with_valid_site_setting) }

    it "has a valid factory" do
      is_expected.to be_valid
    end

    it "is valid with valid attributes" do
      is_expected.to be_valid
    end

    it "is not valid without a title" do
      is_expected.to validate_presence_of(:title)
    end

    it "is not valid with a title longer than 30 characters" do
      is_expected.to validate_length_of(:title).is_at_least(3).is_at_most(30)
    end

    it "is not valid without a favicon" do
      subject.favicon.purge
      is_expected.not_to be_valid
    end

    it "is not valid with a favicon of invalid type" do
      subject.favicon.content_type = "application/pdf"
      is_expected.not_to be_valid
    end

    it "is valid with a favicon of valid type" do
      subject.favicon.content_type = "image/png"
      is_expected.to be_valid
    end

    it "is not valid with a favicon larger than 500 KB" do
      subject.favicon.byte_size = 600.kilobytes
      is_expected.not_to be_valid
      expect(subject.errors.messages[:favicon]).to include(I18n.t("account.site_settings.validations.size"))
    end
  end
end
