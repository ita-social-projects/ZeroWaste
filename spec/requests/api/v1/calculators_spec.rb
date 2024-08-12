# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::CalculatorsController, type: :request do
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
  let(:calculator) { create(:calculator, :diaper_calculator, product: product) }
  let(:valid_params) { { period: :week, price_id: price.id } }

  let(:money_spent) { price.sum.to_i * product.default_usage_per_day * days[valid_params[:period]] }
  let(:items_used) { product.default_usage_per_day * days[valid_params[:period]] }

  let(:expected_result) do
    {
      moneySpent: money_spent,
      itemsUsed: items_used
    }
  end

  let(:invalid_result) do
    {
      moneySpent: -1,
      itemsUsed: -1
    }
  end

  describe "POST /api/v1/calculators/slug}" do
    context "when no year and no month values" do
      let(:period_and_price_error_msg) do
        {
          error: I18n.t("calculators.errors.period_and_price_error_msg")
        }
      end

      it "renders preiod and price error" do
        post api_v1_calculate_path(calculator)

        expect(response).to be_unprocessable
        expect(response.body).to eq(period_and_price_error_msg.to_json)
      end
    end

    context "when no period value" do
      let(:period_error_msg) do
        {
          error: I18n.t("calculators.errors.period_error_msg")
        }
      end

      it "renders period error" do
        post api_v1_calculate_path(calculator), params: { price_id: price.id }

        expect(response).to be_unprocessable
        expect(response.body).to eq(period_error_msg.to_json)
      end
    end

    context "when no price value" do
      let(:price_error_msg) do
        {
          error: I18n.t("calculators.errors.price_error_msg")
        }
      end

      it "renders price error" do
        post api_v1_calculate_path(calculator), params: { period: "week" }

        expect(response).to be_unprocessable
        expect(response.body).to eq(price_error_msg.to_json)
      end
    end

    context "when get awaited values" do
      it "got the expected result" do
        post api_v1_calculate_path(calculator), params: valid_params

        expect(response.body).to eq(expected_result.to_json)
      end
    end

    context "when get unawaited values" do
      it "got the unexpected result" do
        post api_v1_calculate_path(calculator), params: valid_params

        expect(response).to be_successful
        expect(response.body).not_to eq(invalid_result.to_json)
      end
    end
  end
end
