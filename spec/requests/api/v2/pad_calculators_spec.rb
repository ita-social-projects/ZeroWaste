require "swagger_helper"

RSpec.describe "api/v2/pad_calculators", openapi_spec: "v2/swagger.yaml", type: :request do # rubocop:disable RSpec/EmptyExampleGroup
  path "/api/v2/pad_calculators" do
    post("Pad calculator") do
      tags "Pad Calculator"
      description "Calculate pad usage and cost based on user input.
      Available categories: #{Calculators::PadUsageService::PAD_PRICES.keys.map(&:to_s).join(", ")}"

      consumes "application/json"
      produces "application/json"

      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          user_age: { type: :integer, example: 30, description: "User age" },
          menstruation_age: { type: :integer, example: 13, description: "Menstruation age" },
          menopause_age: { type: :integer, example: 50, description: "Menopause age" },
          average_menstruation_cycle_duration: { type: :integer, example: 28, description: "Average menstruation cycle duration" },
          pads_per_cycle: { type: :integer, example: 10, description: "Pads per cycle" },
          pad_category: { type: :string, example: "budget", description: "Pad category" }
        },
        required: ["user_age", "menstruation_age", "average_menstruation_cycle_duration", "pads_per_cycle"]
      }

      response(200, "successful") do
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
        schema type: :object,
               properties: {
                 errors: {
                   type: :object,
                   properties: {
                     user_age: { type: :string, example: "Your age is missing" },
                     menstruation_age: { type: :string, example: "Age at First Menstruation must be in range from 1 to 100" },
                     menopause_age: { type: :string, example: "Age at Menopause is missing" },
                     average_menstruation_cycle_duration: { type: :string, example: "Average Menstrual Cycle Duration (days) is missing" },
                     pads_per_cycle: { type: :string, example: "Average Products Used Per Cycle is missing" },
                     pad_category: { type: :string, example: "This Product Category doesn't exist" }
                   }
                 }
               },
               required: ["errors"]

        run_test!
      end
    end
  end
end
