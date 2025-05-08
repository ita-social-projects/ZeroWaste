require "swagger_helper"

RSpec.describe "api/v1/diaper_calculators", type: :request do
  path "/{locale}/api/v1/diaper_calculators" do
    parameter name: "locale",
              in: :path,
              schema: {
                type: :string,
                enum: ["en", "uk"]
              },
              required: true,
              default: "en",
              description: "Language locale (uk/en)"

    post("Сalculate diaper usage") do
      tags "Diaper Calculator"
      consumes "application/json"
      produces "application/json"

      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          childs_years: { type: :integer, example: 1, description: "Age in years (0-3)" },
          childs_months: { type: :integer, example: 6, description: "Age in months (0-11)" },
          category_id: { type: :integer, example: 2, description: "Category ID (optional)" }
        },
        required: ["childs_years", "childs_months"]
      }

      response(200, "successful") do
        let(:locale) { "en" }
        let(:body) do
          {
            childs_years: 1,
            childs_months: 6,
            category_id: 2
          }
        end

        run_test!
      end

      response(422, "unprocessable entity") do
        let(:locale) { "en" }
        let(:body) { { childs_years: "", childs_months: "" } }

        schema type: :object,
               properties: {
                 errors: { type: :string, example: "Please, select years and months" }
               }

        run_test!
      end
    end
  end
end
