require "rails_helper"

RSpec.describe Calculators::DiaperUsageService do
  let(:category) { create(:category, :medium) }
  let(:empty_category) { create(:category, :without_diapers_period) }

  describe "#calculate" do
    context "when DiapersPeriod records exist" do
      before do
        create(:diapers_period, category: category, period_start: 1, period_end: 12, usage_amount: 8, price: 10)
        create(:diapers_period, category: category, period_start: 13, period_end: 24, usage_amount: 6, price: 12)
      end

      let!(:service) { described_class.new(1, 6, category.id) }

      before do
        service.calculate
      end

      let(:result) { service.result }

      it "calculates the correct values" do
        expect(result[:used_diapers_amount]).to eq(6_771.0)
        expect(result[:used_diapers_price]).to eq(69_906.0)
        expect(result[:to_be_used_diapers_amount]).to eq(2_928.0)
        expect(result[:to_be_used_diapers_price]).to eq(31_476.0)
      end
    end

    context "when there are no DiapersPeriod records" do
      let(:service) { described_class.new(1, 6, empty_category.id) }

      before do
        service.calculate
      end

      let(:result) { service.result }

      it "returns zero values" do
        expect(result[:used_diapers_amount]).to eq(0)
        expect(result[:used_diapers_price]).to eq(0)
        expect(result[:to_be_used_diapers_amount]).to eq(0)
        expect(result[:to_be_used_diapers_price]).to eq(0)
      end
    end
  end
end
