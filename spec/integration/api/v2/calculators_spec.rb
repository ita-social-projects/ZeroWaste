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

      response(200, "successful (example formula is 'first_value+second_value+third_value')") do
        let!(:calculator) { create(:calculator) }
        let!(:slug) { calculator.slug }
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
        let(:body) { { first_value: "medium", second_value: 2, third_value: 3 } }

        after do
          puts Field.first.inspect
        end

        schema type: :object,
               properties: {
                 formula_label: { type: :number, example: 6, description: "Result of the calculation" }
               }

        run_test! do |response|
          expect(JSON.parse(response.body)[calculator.formulas.first.en_label]).to eq("6.0")
        end
      end

      response(422, "unprocessable entity") do
        let!(:calculator) { create(:calculator) }
        let!(:slug) { calculator.slug }
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

        after do
          puts "Response body: #{response.body}"
          puts "Response status: #{response.status}"
        end

        run_test! do |response|
          expect(JSON.parse(response.body)["errors"]["third_value"]).to eq("Label is missing")
          expect(JSON.parse(response.body)["errors"]["first_value"]).to eq("Please, select correct category")
        end
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
