require "rails_helper"

RSpec.describe InvalidLocaleConstraint, type: :routing do
  let(:constraint) { InvalidLocaleConstraint.new }
  let(:valid_request_en) { double("request", path: "/en/api/v2/pad_calculators/calculate") }
  let(:valid_request_uk) { double("request", path: "/uk/api/v2/diaper_calculators/calculate") }
  let(:invalid_request_fr) { double("request", path: "/fr/api/v2/diaper_calculators/calculate") }
  let(:api_request) { double("request", path: "/api/v2/pad_calculators/calculate") }
  let(:non_api_request) { double("request", path: "/en/pad_calculators/calculate") }

  describe "#matches?" do
    context "when the locale is invalid" do
      it "returns true for an invalid locale in the path" do
        expect(constraint.matches?(invalid_request_fr)).to be true
      end
    end

    context "when the locale is valid" do
      it "returns false for a valid locale in the path (uk)" do
        expect(constraint.matches?(valid_request_uk)).to be false
      end

      it "returns false for a valid locale in the path (en)" do
        expect(constraint.matches?(valid_request_en)).to be false
      end
    end

    context "when the path does not match the API v2 prefix" do
      it "returns false for a non-API v2 path" do
        expect(constraint.matches?(non_api_request)).to be false
      end
    end

    context "when the locale segment is missing" do
      it "returns false when there is no locale segment" do
        expect(constraint.matches?(api_request)).to be false
      end
    end
  end
end
