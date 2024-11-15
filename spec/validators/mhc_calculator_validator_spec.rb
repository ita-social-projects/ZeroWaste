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

  describe "#valid?" do
    context "when all parameters are valid" do
      it "returns true" do
        validator = described_class.new(valid_params)

        expect(validator.valid?).to be true
        expect(validator.errors).to be_empty
      end
    end

    context "when some parameter is missing" do
      it "returns false" do
        invalid_params = valid_params.except(:user_age)
        validator      = described_class.new(invalid_params)

        expect(validator.valid?).to be false
        expect(validator.errors).to include(:user_age)
        expect(validator.errors[:user_age]).to eq(I18n.t("calculators.errors.presence_error_msg", field: I18n.t("calculators.mhc_calculator.form.user_age")))
      end
    end
  end
end
