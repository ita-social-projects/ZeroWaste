require "swagger_helper"

RSpec.describe "api/v2/diaper_calculators", openapi_spec: "v2/swagger.yaml", type: :request do # rubocop:disable RSpec/EmptyExampleGroup
  path "/api/v2/diaper_calculators" do
    post("Сalculate diaper usage") do
      tags "Diaper Calculator"
      description "Calculate diaper usage based on user input"
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
        run_test!
      end

      response(422, "unprocessable entity") do
        schema type: :object,
               properties: {
                 errors: { type: :string, example: "Please, select years and months" }
               },
               required: ["errors"]

        run_test!
      end
    end
  end
end
