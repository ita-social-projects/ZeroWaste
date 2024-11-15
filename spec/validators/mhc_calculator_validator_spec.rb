# spec/validators/mhc_calculator_validator_spec.rb

require "rails_helper"

RSpec.describe MhcCalculatorValidator do
  let(:valid_params) do
    {
      user_age: 30,
      menstruation_age: 13,
      menopause_age: 50,
      average_menstruation_cycle_duration: 28,
      pads_per_cycle: 10,
      pad_category: "budget"
    }
  end
  let(:local_error_prefix) { "calculators.errors" }
  let(:local_field_prefix) { "calculators.mhc_calculator.form" }

  describe "#valid?" do
    context "when all parameters are valid" do
      it "returns true" do
        validator = described_class.new(valid_params)

        expect(validator.valid?).to be true
        expect(validator.errors).to be_empty
      end
    end

    context "when some parameter is missing" do
      let(:invalid_params) { valid_params.except(:user_age, :pads_per_cycle) }

      it "returns false" do
        validator = described_class.new(invalid_params)

        expect(validator.valid?).to be false
        expect(validator.errors).to include(:user_age)
        expect(validator.errors[:user_age]).to eq(I18n.t("#{local_error_prefix}.presence_error_msg", field: I18n.t("#{local_field_prefix}.user_age")))
      end
    end
  end

  describe "individual validations" do
    shared_examples "a presence validation" do |attribute|
      it "#{attribute} is valid when present" do
        expect(validator.send(:"validate_#{attribute}")).to be true
        expect(validator.errors[attribute]).to be_nil
      end

      it "#{attribute} is invalid when blank" do
        validator.params[attribute] = nil

        expect(validator.send(:"validate_#{attribute}")).to be false
        expect(validator.errors[attribute]).to eq(I18n.t("#{local_error_prefix}.presence_error_msg", field: I18n.t("#{local_field_prefix}.#{attribute}")))
      end
    end

    let!(:validator) { described_class.new(valid_params) }

    context "user age validation" do
      include_examples "a presence validation", :user_age
    end

    context "menstruation age validation" do
      include_examples "a presence validation", :menstruation_age
    end

    context "menopause age validation" do
      include_examples "a presence validation", :menopause_age
    end

    context "average menstruation cycle duration validation" do
      include_examples "a presence validation", :average_menstruation_cycle_duration
    end

    context "pads per cycle validation" do
      include_examples "a presence validation", :pads_per_cycle
    end

    context "pad category validation" do
      include_examples "a presence validation", :pad_category
    end
  end
end
