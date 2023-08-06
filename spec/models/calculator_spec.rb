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
  subject { build(:calculator, :diaper_calculator) }

  describe "validations" do
    it {
      is_expected.to validate_presence_of(:name).with_message(
        I18n.t("#{LOCAL_PREFIX_CALCULATOR}.name.too_short")
      )
    }
    it {
      is_expected.to validate_length_of(:name).is_at_least(2).with_message(
        I18n.t("#{LOCAL_PREFIX_CALCULATOR}.name.too_short")
      )
    }
    it {
      is_expected.not_to allow_value("Hh@").for(:name).with_message(
        I18n.t("#{LOCAL_PREFIX_CALCULATOR}.name.name_format_validation")
      )
    }
    it {
      is_expected.to validate_uniqueness_of(:name)
    }
  end

  describe "scope" do
    context "finds instances by slug and name" do
      let!(:calc) { create(:calculator, :diaper_calculator, slug: "calc") }
      let!(:calc2) { create(:calculator, :diaper_calculator, slug: "diapers", name: "Calculator") }

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
end
