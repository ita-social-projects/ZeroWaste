# spec/validators/mhc_calculator_validator_spec.rb

require "rails_helper"

RSpec.describe MhcCalculatorValidator do
  let(:valid_params) do
    {
      user_age: 30,
      menstruation_age: 13,
      menopause_age: 50,
      average_menstruation_cycle_duration: 28,
      duration_of_menstruation: 4,
      disposable_products_per_day: 5,
      product_type: "tampons",
      pad_category: "budget"
    }
  end
  let!(:validator) { described_class.new(valid_params) }

  let(:local_error_prefix) { "calculators.errors" }
  let(:local_field_prefix) { "calculators.mhc_calculator.form" }

  describe "#valid?" do
    context "when all parameters are valid" do
      it "returns true" do
        expect(validator.valid?).to be true
        expect(validator.errors).to be_empty
      end
    end

    context "when some parameter is missing" do
      let(:invalid_params_validator) { described_class.new(valid_params.except(:user_age)) }

      it "returns false" do
        expect(invalid_params_validator.valid?).to be false
        expect(invalid_params_validator.errors).to include(:user_age)
        expect(invalid_params_validator.errors[:user_age]).to eq(I18n.t("#{local_error_prefix}.presence_error_msg", field: I18n.t("#{local_field_prefix}.user_age")))
      end
    end
  end

  describe "individual validations" do
    context "user age validation" do
      include_examples "presence validation", :user_age
    end

    context "menstruation age validation" do
      include_examples "presence validation", :menstruation_age
    end

    context "menopause age validation" do
      include_examples "presence validation", :menopause_age
    end

    context "average menstruation cycle duration validation" do
      include_examples "presence validation", :average_menstruation_cycle_duration
    end

    context "duration of menstruation validation" do
      include_examples "presence validation", :duration_of_menstruation
    end

    context "disposable products per day validation" do
      include_examples "presence validation", :disposable_products_per_day
    end

    context "product type validation" do
      include_examples "presence validation", :product_type
    end

    context "pad category validation" do
      include_examples "presence validation", :pad_category
    end
  end
end
