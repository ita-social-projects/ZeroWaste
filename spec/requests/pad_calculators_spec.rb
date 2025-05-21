# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::PadCalculatorsController, type: :request do
  let(:expected_result) do
    {
      already_used_products: 4420,
      already_used_products_cost: 8840,
      products_to_be_used: 5460,
      products_to_be_used_cost: 10920
    }
  end

  let(:valid_params) do
    {
      user_age: 30,
      menstruation_age: 13,
      menopause_age: 51,
      average_menstruation_cycle_duration: 28,
      duration_of_menstruation: 4,
      disposable_products_per_day: 5,
      product_type: :pads,
      pad_category: :budget
    }
  end

  describe "POST /pad_calculators" do
    context "when params are valid" do
      it "return expected results" do
        post api_v1_pad_calculators_path, params: valid_params, as: :json

        expect(response).to be_successful
        expect(response.body).to eq(expected_result.to_json)
      end
    end

    context "when params are invalid" do
      it "return errors" do
        post api_v1_pad_calculators_path

        expect(response).to be_unprocessable
        expect(JSON.parse(response.body, symbolize_names: true)).to have_key(:errors)
      end
    end
  end
end
