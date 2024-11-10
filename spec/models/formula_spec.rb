# == Schema Information
#
# Table name: formulas
#
#  id            :bigint           not null, primary key
#  en_label      :string           not null
#  en_unit       :string
#  expression    :string           default(""), not null
#  uk_label      :string           default(""), not null
#  uk_unit       :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  calculator_id :bigint           not null
#
# Indexes
#
#  index_formulas_on_calculator_id  (calculator_id)
#
# Foreign Keys
#
#  fk_rails_...  (calculator_id => calculators.id)
#
require "rails_helper"

RSpec.describe Formula, type: :model do
  let(:local_prefix_formula) { "activerecord.errors.models.formula.attributes" }
  let(:calculator) { create(:calculator) }
  let!(:formula) { build(:formula, expression: "a + b", calculator: calculator) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:uk_label) }
    it { is_expected.to validate_length_of(:uk_label).is_at_least(3).is_at_most(50) }
    it { is_expected.to validate_presence_of(:en_label) }
    it { is_expected.to validate_length_of(:en_label).is_at_least(3).is_at_most(50) }
    it { is_expected.to validate_presence_of(:uk_unit) }
    it { is_expected.to validate_length_of(:uk_unit).is_at_least(1).is_at_most(30) }
    it { is_expected.to validate_presence_of(:en_unit) }
    it { is_expected.to validate_length_of(:en_unit).is_at_least(1).is_at_most(30) }
    it { is_expected.to validate_presence_of(:expression) }

    context "formula has all fields initialized" do
      before do
        calculator.fields.build(var_name: "a")
        calculator.fields.build(var_name: "b")
      end

      it "is valid" do
        expect(formula).to be_valid
      end
    end

    context "formula has some fields not initialized" do
      it "is invalid" do
        expect(formula).not_to be_valid
        expect(formula.errors[:expression]).to include(I18n.t("#{local_prefix_formula}.expression.uninitialized_fields", fields: "a, b", count: 2))
      end
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:calculator) }
  end
end
