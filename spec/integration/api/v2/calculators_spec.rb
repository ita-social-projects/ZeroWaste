require "swagger_helper"

RSpec.describe "calculators", openapi_spec: "v2/swagger.yaml", type: :request do # rubocop:disable RSpec/EmptyExampleGroup
  path "/calculators/{slug}/calculate" do
    post("calculate calculator") do
      tags "Calculators by constructor"
      description "Calculate calculator based on user input. Available calculators can be revealed by GET /calculators"

      consumes "application/json"
      produces "application/json"

      parameter name: "slug", in: :path, type: :string, description: "slug of the calculator", required: true
      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          first_value: { type: :number, example: 1, description: "First value" },
          second_value: { type: :number, example: 2, description: "Second value" },
          third_value: { type: :number, example: 3, description: "Third value" }
        }
      }
      response(200, "successful (formula equals first_value+second_value+third_value)") do
        let(:calculator) { create(:calculator) }
        let(:formula) { build(:formula, expression: "first_value+second_value+third_value", calculator: calculator) }
        let(:fields) { build(:field, 3, var_name: ["field_1", "field_2", "field_3"], calculator: calculator) }
        let(:slug) { calculator.slug }
        let!(:body) do
          {
            first_value: 1,
            second_value: 2,
            third_value: 3
          }
        end

        schema type: :object,
               properties: {
                 Label: { type: :number, example: 6, description: "Result of the calculation" }
               }

        run_test!
      end
    end
  end

  # path "(/{locale)}/api/v2/calculators" do

  #   get("list calculators") do
  #     response(200, "successful") do
  #       let(:locale) { "123" }

  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           "application/json" => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end

  #       run_test!
  #     end
  #   end
  # end
end
