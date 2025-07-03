require "swagger_helper"

RSpec.describe "/pad_calculators", openapi_spec: "v2/swagger.yaml", type: :request do
  let(:user) { create(:user) }

  let(:jwt_token) do
    Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
  end

  let(:Authorization) { "Bearer #{jwt_token}" }

  path "/pad_calculators" do
    post("Pad calculator") do
      tags "Pad Calculator"
      security [bearerAuth: []]
      description "Calculate pad usage and cost based on user input.
      Available types: #{Calculators::PadUsageService::PRODUCT_PRICES.keys.map(&:to_s).join(", ")}"

      consumes "application/json"
      produces "application/json"

      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          user_age: { type: :integer, example: 30, description: "User age" },
          menstruation_age: { type: :integer, example: 13, description: "Menstruation age" },
          menopause_age: { type: :integer, example: 50, description: "Menopause age" },
          average_menstruation_cycle_duration: { type: :integer, example: 28, description: "Average menstruation cycle duration" },
          duration_of_menstruation: { type: :integer, example: 5, description: "Duration of menstruation in days" },
          disposable_products_per_day: { type: :integer, example: 10, description: "Disposable products per day" },
          product_type: { type: :string, example: "pads", description: "Product type (pads or tampons)" },
          pad_category: { type: :string, example: "budget", description: "Pad category" }
        },
        required: ["user_age", "menstruation_age", "average_menstruation_cycle_duration", "disposable_products_per_day"]
      }

      response(200, "successful") do
        let(:Authorization) { "Bearer #{jwt_token}" }

        let(:body) do
          {
            user_age: 30,
            menstruation_age: 13,
            menopause_age: 50,
            average_menstruation_cycle_duration: 28,
            duration_of_menstruation: 5,
            disposable_products_per_day: 10,
            product_type: "pads",
            pad_category: "budget"
          }
        end

        schema type: :object,
               properties: {
                 already_used_products: { type: :integer, example: 2210, description: "Already used products" },
                 already_used_products_cost: { type: :integer, example: 4420, description: "Already used products cost" },
                 products_to_be_used: { type: :integer, example: 2600, description: "Products to be used" },
                 products_to_be_used_cost: { type: :integer, example: 5200, description: "Products to be used cost" }
               }

        run_test!
      end

      response(422, "unprocessable entity") do
        let(:Authorization) { "Bearer #{jwt_token}" }

        let(:body) {}

        schema type: :object,
               properties: {
                 errors: {
                   type: :object,
                   properties: {
                     user_age: { type: :string, example: "Your age is missing" },
                     menstruation_age: { type: :string, example: "Age at First Menstruation must be in range from 1 to 100" },
                     menopause_age: { type: :string, example: "Age at Menopause is missing" },
                     average_menstruation_cycle_duration: { type: :string, example: "Average Menstrual Cycle Duration (days) is missing" },
                     duration_of_menstruation: { type: :string, example: "Duration of Menstruation (days) is missing" },
                     disposable_products_per_day: { type: :string, example: "Average Products Used Per Cycle is missing" },
                     product_type: { type: :string, example: "Product Type is missing" },
                     pad_category: { type: :string, example: "Product Category is missing" }
                   }
                 }
               },
               required: ["errors"]

        run_test!
      end
    end
  end
end
