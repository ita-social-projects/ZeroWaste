# frozen_string_literal: true

# == Schema Information
#
# Table name: calculators
#
#  id         :bigint           not null, primary key
#  name       :string
#  preferable :boolean          default(FALSE)
#  slug       :string
#  uuid       :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_calculators_on_name  (name) UNIQUE
#  index_calculators_on_slug  (slug) UNIQUE
#  index_calculators_on_uuid  (uuid) UNIQUE
#
require "rails_helper"

LOCAL_PREFIX_CALCULATOR = "activerecord.errors.models.calculator.attributes"

RSpec.describe Calculator, type: :model do
  subject { build(:calculator) }

  describe "validations" do
    it "validates the name and message " do
      is_expected.to validate_presence_of(:name)
        .with_message(I18n.t("#{LOCAL_PREFIX_CALCULATOR}.name.blank"))
    end

    it "validates the name's length and message" do
      is_expected.to validate_length_of(:name).is_at_least(2)
                                              .with_message(I18n.t("#{LOCAL_PREFIX_CALCULATOR}.name.too_short", count: 2))

      is_expected.to validate_length_of(:name).is_at_most(30)
                                              .with_message(I18n.t("#{LOCAL_PREFIX_CALCULATOR}.name.too_long", count: 30))
    end

    it "validates the name's uniqueness and message" do
      is_expected.to validate_uniqueness_of(:name)
        .with_message(I18n.t("#{LOCAL_PREFIX_CALCULATOR}.name.taken"))
    end

    context "validates the name format" do
      let(:calculator) { build(:calculator) }

      it "with valid name" do
        calculator.name = "Hedgehog і єнот з'їли 2 аґруси"

        expect(calculator).to be_valid
      end

      it "with invalid name" do
        ["#", "!", "@", "$", "%", "^", "&", "*", "(", ")", "?", "\"", "_"].each do |sym|
          calculator.name = "Invalid Name #{sym}"

          expect(calculator).to_not be_valid
          expect(calculator.errors.messages[:name]).to include(I18n.t("#{LOCAL_PREFIX_CALCULATOR}.name.invalid"))
        end
      end
    end
  end

  describe "scope" do
    context "finds instances by slug and name" do
      let!(:calc) { create(:calculator, slug: "calc") }
      let!(:calc2) { create(:calculator, slug: "diapers", name: "Calculator") }

      it "finds two instances by slug or name" do
        expect(Calculator.by_name_or_slug("calc").to_a).to include(calc, calc2)
      end

      it "returns all instances when search params are empty" do
        expect(Calculator.by_name_or_slug("    ").to_a).to include(calc, calc2)
      end

      it "returns all instances when search params are nil" do
        expect(Calculator.by_name_or_slug(nil).to_a).to include(calc, calc2)
      end

      it "does not find any instances" do
        expect(Calculator.by_name_or_slug("qwerty").to_a).to eq []
      end
    end
  end

  describe "versioning", versioning: true do
    let!(:calculator) { create(:calculator, name: "Calculator 1") }

    it "adds a version when the calculator is updated" do
      calculator.update!(name: "Calculator 2")

      expect(calculator.versions.count).to eq(2)
    end
  end
end
