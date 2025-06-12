# frozen_string_literal: true

# == Schema Information
#
# Table name: calculators
#
#  id         :bigint           not null, primary key
#  color      :string           default("#000000")
#  en_name    :string           default(""), not null
#  slug       :string
#  uk_name    :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_calculators_on_slug  (slug) UNIQUE
#
require "rails_helper"

RSpec.describe Calculator, type: :model do
  let(:local_prefix_calculator) { "activerecord.errors.models.calculator.attributes" }
  let(:calculator) { build(:calculator) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:en_name) }
    it { is_expected.to validate_length_of(:en_name).is_at_least(3).is_at_most(50) }
    it { is_expected.to validate_presence_of(:uk_name) }
    it { is_expected.to validate_length_of(:uk_name).is_at_least(3).is_at_most(50) }
    it { is_expected.to validate_uniqueness_of(:slug) }
    it { is_expected.to validate_length_of(:en_notes).is_at_most(500) }
    it { is_expected.to validate_length_of(:uk_notes).is_at_most(500) }
    it { is_expected.to allow_value("#123abc").for(:color) }
    it { is_expected.to allow_value("#ABCDEF").for(:color) }
    it { is_expected.not_to allow_value("123abc").for(:color) }
    it { is_expected.not_to allow_value("#12345").for(:color) }
    it { is_expected.not_to allow_value("#1234567").for(:color) }
    it { is_expected.not_to allow_value("#GHIJKL").for(:color) }
  end

  describe "associations" do
    it { is_expected.to have_one_attached(:logo_picture) }
    it { is_expected.to have_many(:fields).dependent(:destroy) }
    it { is_expected.to have_many(:formulas).dependent(:destroy) }
  end

  describe "logo_placeholder attribute" do
    it "has a default value" do
      expect(calculator.logo_placeholder).to eq("https://via.placeholder.com/428x307?text=Logo")
    end
  end

  describe "#strip_tags_and_tokenize" do
    let(:stripped_content) { Calculator.new.strip_tags_and_tokenize(content) }

    context "when contents is simple" do
      let(:content) { "<p>#{"a" * 500}</p>" }

      it "ensures the stripped content length is correct" do
        expect(stripped_content.length).to eq(500)
      end
    end
  end

  describe "#logo_url" do
    context "when logo_picture is attached" do
      let(:logo_image) { Rails.root.join("spec", "fixtures", "icons", "favicon-181x182.png") }

      before do
        calculator.logo_picture.attach(logo_image)

        allow(Rails.application.routes.url_helpers).to receive(:rails_blob_url)
          .with(calculator.logo_picture, only_path: true)
          .and_return("/rails/active_storage/blobs/favicon-181x182.png")
      end

      it "returns the attached logo URL" do
        expect(calculator.logo_url).to eq("/rails/active_storage/blobs/favicon-181x182.png")
      end
    end

    context "when logo_picture is not attached" do
      it "returns the default image path" do
        expect(calculator.logo_url).to eq("scales.png")
      end
    end
  end

  describe ".ransackable_attributes" do
    it "returns the correct list of attributes" do
      expect(Calculator.ransackable_attributes).to include("created_at", "id", "name", "preferable", "slug", "updated_at", "uuid")
    end
  end

  describe ".ransacker :name" do
    let!(:calculator) { create(:calculator) }
    let(:result_en) { Calculator.ransack(name_eq: calculator.en_name).result }
    let(:result_uk) { Calculator.ransack(name_eq: calculator.uk_name).result }

    it "returns en_name when locale is :en" do
      I18n.with_locale(:en) do
        expect(result_en).to include(calculator)
      end
    end

    it "returns uk_name when locale is :uk" do
      I18n.with_locale(:uk) do
        expect(result_uk).to include(calculator)
      end
    end
  end
end
