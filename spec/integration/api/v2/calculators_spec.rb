require "swagger_helper"

RSpec.describe "calculators", openapi_spec: "v2/swagger.yaml", type: :request do # rubocop:disable RSpec/EmptyExampleGroup
  let!(:calculator) { create(:calculator) }
  let!(:formula) do
    build(:formula,
          calculator: calculator,
          expression: "first_value+second_value+third_value")
      .save(validate: false)
  end
  let!(:category_field) do
    build(:field,
          kind: "category",
          calculator: calculator,
          var_name: "first_value").save(validation: false)
  end
  let!(:fields) do
    ["second_value", "third_value"].map do |var_name|
      build(:field, calculator: calculator, var_name: var_name).save(validate: false)
    end
  end
  let!(:category) { create(:category, :medium, price: 1, field: Field.first) }

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

      response(200, "successful (example formula is 'first_value+second_value+third_value')") do
        let!(:slug) { calculator.slug }

        let(:body) { { first_value: "medium", second_value: 2, third_value: 3 } }

        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   label: { type: :string },
                   result: { type: :string },
                   unit: { type: :string },
                   relation: { type: :string, nullable: true }
                 },
                 required: ["label", "result", "unit"]
               }

        run_test! do |response|
          expect(JSON.parse(response.body)[0]["result"]).to eq("6.0")
        end
      end

      response(422, "unprocessable entity") do
        let!(:slug) { calculator.slug }
        let(:body) { { first_value: "not_valid_name", second_value: 2 } }

        schema type: :object,
               properties: {
                 errors: {
                   type: :object,
                   properties: {
                     third_value: { type: :string }
                   }
                 }
               },
               required: ["errors"]

        run_test! do |response|
          expect(JSON.parse(response.body)["errors"]["third_value"]).to eq("Label is missing")
          expect(JSON.parse(response.body)["errors"]["first_value"]).to eq("Please, select correct category")
        end
      end
    end
  end

  path "/calculators" do
    get("list calculators") do
      tags "Calculators by constructor"
      description "List all calculators available in the system. Each calculator has a slug that can be used to access it directly."

      consumes "application/json"
      produces "application/json"

      parameter name: "name", in: :query, type: :enum, enum: ["desc", "asc"], description: "Sort by name", required: false, default: "asc"

      response(200, "successful") do
        run_test! do |response|
          expect(JSON.parse(response.body).size).to eq(1)
        end
      end
    end
  end
end
