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

RSpec.describe Calculator, type: :model do
  let(:local_prefix_calculator) { "activerecord.errors.models.calculator.attributes" }

  subject { build(:calculator) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:en_name) }
    it { is_expected.to validate_length_of(:en_name).is_at_least(3).is_at_most(50) }
    it { is_expected.to validate_presence_of(:uk_name) }
    it { is_expected.to validate_length_of(:uk_name).is_at_least(3).is_at_most(50) }
    it { is_expected.to validate_presence_of(:slug) }
    it { is_expected.to validate_uniqueness_of(:slug) }
    it { is_expected.to validate_length_of(:english_additional_notes).is_at_most(150) }
    it { is_expected.to validate_length_of(:ukranian_additional_notes).is_at_most(150) }
  end

  describe "associations" do
    it { is_expected.to have_many(:fields).dependent(:destroy) }
    it { is_expected.to have_many(:formulas).dependent(:destroy) }
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
