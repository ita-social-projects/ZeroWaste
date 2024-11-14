# frozen_string_literal: true

# == Schema Information
#
# Table name: fields
#
#  id            :bigint           not null, primary key
#  en_label      :string           default(""), not null
#  field_type    :string           default(""), not null
#  uk_label      :string           default(""), not null
#  var_name      :string           default(""), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  calculator_id :bigint           not null
#
# Indexes
#
#  index_fields_on_calculator_id  (calculator_id)
#
require "rails_helper"

RSpec.describe Field, type: :model do
  let(:local_prefix_field) { "activerecord.errors.models.field.attributes" }
  let(:calculator) { create(:calculator) }
  let!(:field) { build(:field, var_name: "a", calculator: calculator) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:uk_label) }
    it { is_expected.to validate_length_of(:uk_label).is_at_least(3).is_at_most(50) }
    it { is_expected.to validate_presence_of(:en_label) }
    it { is_expected.to validate_length_of(:en_label).is_at_least(3).is_at_most(50) }
    it { is_expected.to validate_presence_of(:var_name) }
    it { is_expected.to allow_value("valid_var_name").for(:var_name) }
    it { is_expected.not_to allow_value("valid_var@21name").for(:var_name) }
    it {
      is_expected.to validate_presence_of(:kind).with_message(I18n
                                                                .t("#{local_prefix_field}.kind.blank"))
    }
    it {
      is_expected.to define_enum_for(:kind)
        .with_values([:number, :category])
    }
    it {
      is_expected.to define_enum_for(:unit)
        .with_values([:day, :week, :month, :year, :date, :times, :money, :items])
    }

    context "field is used in any of calculators formulas" do
      before do
        calculator.formulas.build(expression: "a + b")
      end

      it "is valid when field is used in any of calculators formulas" do
        expect(field).to be_valid
      end
    end

    context "field isn't used in any of calculators formulas" do
      before do
        calculator.formulas.build(expression: "y + c")
      end

      it "is invalid" do
        expect(field).not_to be_valid
        expect(field.errors[:var_name]).to include(I18n.t("#{local_prefix_field}.var_name.unused_in_formula"))
      end
    end

    context "field isn't unique within its calculator" do
      before do
        calculator.fields.build(var_name: "a")
        calculator.fields.build(var_name: "a")
      end

      it "is invalid" do
        expect(field).not_to be_valid
        expect(field.errors[:var_name]).to include(I18n.t("#{local_prefix_field}.var_name.calculator_var_name_uniqueness", count: 2))
      end
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:calculator) }
  end

  describe "#set_selector" do
    let(:calculator) { create(:calculator) }
    let(:field) { build(:field, label: "new", kind: 0, calculator: calculator) }

    context "when there is no form fields in a database" do
      it "generates selector with one letter and a number" do
        expect { field.save }.to change { field.selector }.from(nil).to("F1")
      end
    end

    context "when there are more forms fields in a database" do
      before do
        create(:field, label: "new", kind: 0, calculator: calculator)
      end

      it "generates selector with one letter and an increased number" do
        expect { field.save }.to change { field.selector }.from(nil).to("F2")
      end
    end
  end
end
