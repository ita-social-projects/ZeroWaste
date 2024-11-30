require "rails_helper"

RSpec.describe Calculators::PadUsageService do
  describe "#calculate" do
    let!(:service) do
      described_class.new(
        user_age: 30,
        menstruation_age: 13,
        menopause_age: 51,
        pads_per_cycle: 20,
        average_menstruation_cycle_duration: 28,
        pad_category: :budget
      )
    end

    before do
      service.calculate
    end

    let(:result) { service.calculate }

    it "calculates the correct values" do
      expect(result[:already_used_products]).to eq(4_420.0)
      expect(result[:already_used_products_cost]).to eq(8_840.0)
      expect(result[:products_to_be_used]).to eq(5_460.0)
      expect(result[:products_to_be_used_cost]).to eq(10_920.0)
    end
  end
end
