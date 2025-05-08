require "swagger_helper"

RSpec.describe "api/v1/pad_calculators", type: :request do
  path "(/{locale)}/api/v1/pad_calculators" do
    parameter name: "locale",
              in: :path,
              schema: {
                type: :string,
                enum: ["en", "uk"]
              },
              required: true,
              default: "en",
              description: "Language locale (uk/en)"

    post("Pad calculator") do
      response(200, "successful") do
        let(:locale) { "123" }

        after do |example|
          example.metadata[:response][:content] = {
            "application/json" => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end
    end
  end
end
