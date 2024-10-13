# frozen_string_literal: true

require "rails_helper"

RSpec.describe CalculatorForm, type: :model do
  let(:prefix) { "activemodel.errors.models.calculator_form.attributes" }
  let(:price) { create(:price, :budgetary_price) }
  let(:valid_params) { { period: "week", price_id: price.id } }

  subject { described_class.new(valid_params) }

  describe "validations" do
    it "is valid with valid attributes" do
      is_expected.to be_valid
    end

    it "validates presence of period with error message" do
      is_expected.to validate_presence_of(:period)
        .with_message(I18n.t("#{prefix}.period.blank"))
    end

    it "validates presence of price_id with error message" do
      is_expected.to validate_presence_of(:price_id)
        .with_message(I18n.t("#{prefix}.price_id.blank"))
    end
  end
end
