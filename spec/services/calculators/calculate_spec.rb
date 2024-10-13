# frozen_string_literal: true

require "rails_helper"

RSpec.describe Calculators::CalculateService do
  let(:days) do
    {
      day: 1,
      week: 7,
      month: 30.5,
      year: 365
    }
  end
  let(:product) { create(:product, :diaper, default_usage_per_day: 3) }
  let(:category) { create(:category, :budgetary) }
  let(:price) { create(:price, :budgetary_price, priceable: product, category: category) }
  let(:valid_params) { { period: "week", price_id: price.id } }

  describe "#calculate" do
    context "when the period is 'week'" do
      let(:money_spent) { price.sum.to_i * product.default_usage_per_day * days[:week] }
      let(:items_used) { product.default_usage_per_day * days[:week] }

      subject(:result) { described_class.new(product, valid_params).calculate }

      it "calculates correctly" do
        expect(result[:moneySpent]).to eq(money_spent)
        expect(result[:itemsUsed]).to eq(items_used)
      end
    end
  end
end
