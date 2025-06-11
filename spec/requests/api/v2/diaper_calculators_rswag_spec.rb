# spec/requests/api/v2/diaper_calculators_spec.rb

require "swagger_helper"

RSpec.describe "/diaper_calculators", openapi_spec: "v2/swagger.yaml", type: :request do
  let!(:category) { create(:category, :medium, id: 1) }
  let(:user) { create(:user) }

  let(:jwt_token) do
    Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
  end

  let(:Authorization) { "Bearer #{jwt_token}" }

  path "/diaper_calculators" do
    post("Calculate diaper usage") do
      tags "Diaper Calculator"
      security [bearerAuth: []]
      consumes "application/json"
      produces "application/json"

      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          childs_years: { type: :integer, example: 1, description: "Age in years (0-3)" },
          childs_months: { type: :integer, example: 6, description: "Age in months (0-11)" },
          category_id: { type: :integer, example: 1, description: "Category ID" }
        },
        required: ["childs_years", "childs_months", "category_id"]
      }

      response(200, "successful") do
        let(:Authorization) { "Bearer #{jwt_token}" }

        let(:body) do
          {
            childs_years: 1,
            childs_months: 6,
            category_id: 1
          }
        end

        schema type: :object,
               properties: {
                 result: {
                   type: :object,
                   properties: {
                     money_spent: { type: :string, example: "31093.5" },
                     money_will_be_spent: { type: :string, example: "12220.7" },
                     used_diapers_amount: { type: :number, example: 3477 },
                     to_be_used_diapers_amount: { type: :number, example: 1098 },
                     used_diapers_amount_pluralize: { type: :string, example: "already used" },
                     to_be_used_diapers_amount_pluralize: { type: :string, example: "to be used in the future" }
                   }
                 },
                 date: { type: :integer, example: 18 },
                 text_products_to_be_used: { type: :string, example: "1098.0 to be used in the future" },
                 text_products_used: { type: :string, example: "3477.0 already used" }
               }

        run_test!
      end

      response(422, "unprocessable entity") do
        let(:Authorization) { "Bearer #{jwt_token}" }

        let(:body) { {} }

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
