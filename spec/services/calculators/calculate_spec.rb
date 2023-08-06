# frozen_string_literal: true

require "rails_helper"

RSpec.describe Calculators::CalculateService do
  DAYS = { # rubocop:disable Lint/ConstantDefinitionInBlock
    "day" => 1,
    "week" => 7,
    "month" => 30.5,
    "year" => 365
  }.freeze

  let(:product) { create(:product, :diaper, default_usage_per_day: 3) }
  let(:category) { create(:category, :budgetary) }
  let(:price) { create(:price, :budgetary_price, priceable: product, category: category) }
  let(:valid_params) { { period: "week", price_id: price.id } }

  let(:money_spent) { price.sum.to_i * product.default_usage_per_day * DAYS[valid_params[:period]] }
  let(:items_used) { product.default_usage_per_day * DAYS[valid_params[:period]] }

  it "calculates correctly" do
    calculate_service = Calculators::CalculateService.new(product, valid_params)

    result = calculate_service.calculate

    # Your expectations here
    expect(result[:moneySpent]).to eq(money_spent)
    expect(result[:itemsUsed]).to eq(items_used)
  end
end
