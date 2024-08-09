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
    subject { described_class.current }

    before { subject.update(site_setting_params) }

    let(:site_setting_params) { attributes_for(:site_setting, :with_valid_site_setting) }

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

    context "with an invalid favicon type" do
      let(:invalid_favicon_format) { "application/pdf" }

      before do
        subject.favicon.content_type = invalid_favicon_format
      end

      it "is not valid" do
        is_expected.not_to be_valid
      end
    end

    context "with a valid favicon type" do
      let(:valid_favicon_format) { "image/png" }

      before do
        subject.favicon.content_type = valid_favicon_format
      end

      it "is valid" do
        is_expected.to be_valid
      end
    end

    context "with a favicon larger than 1 KB" do
      let(:invalid_favicon_size) { 2.kilobytes }

      before do
        subject.favicon.byte_size = invalid_favicon_size
      end

      it "is not valid" do
        is_expected.not_to be_valid
        expect(subject.errors.messages[:favicon].join).to include(
          I18n.t("errors.messages.file_size_out_of_range")
        )
      end
    end

    context "with a favicon larger than 180x180 pixels" do
      let(:site_setting_params) { attributes_for(:site_setting, :invalid_favicon) }

      it "is not valid" do
        is_expected.not_to be_valid
        expect(subject.errors.messages[:favicon]).to include(
          I18n.t("errors.messages.dimension_width_less_than_or_equal_to", length: 180)
        )
      end
    end

    context "with a favicon with not square acpect ratio" do
      let(:site_setting_params) { attributes_for(:site_setting, :invalid_favicon) }

      it "is not valid" do
        is_expected.not_to be_valid
        expect(subject.errors.messages[:favicon]).to include(
          I18n.t("errors.messages.aspect_ratio_not_square")
        )
      end
    end
  end
end
