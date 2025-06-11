require "rails_helper"

RSpec.describe "API V2 Sessions", type: :request do
  let(:user) { create(:user, email: "user@example.com", password: "password123") }

  describe "POST /api/v2/sign_in" do
    context "with valid credentials" do
      it "returns a JWT token in headers" do
        post "/en/api/v2/sign_in", params: {
          user: {
            email: user.email,
            password: "password123"
          }
        }, as: :json

        expect(response).to have_http_status(:ok)
        expect(response.headers["Authorization"]).to be_present

        json = response.parsed_body
        expect(json["user"]).to eq(user.email)
        expect(json["token"]).to be_present
      end
    end

    context "with invalid credentials" do
      it "returns unauthorized" do
        post "/en/api/v2/sign_in", params: {
          user: {
            email: user.email,
            password: "wrong_password"
          }
        }, as: :json

        expect(response).to have_http_status(:unauthorized)
        expect(response.headers["Authorization"]).to be_nil
      end
    end
  end

  describe "DELETE /api/v2/sign_out" do
    it "revokes the JWT token" do
      post "/en/api/v2/sign_in", params: {
        user: {
          email: user.email,
          password: "password123"
        }
      }, as: :json

      token = response.headers["Authorization"]
      expect(token).to be_present

      delete "/en/api/v2/sign_out", headers: { "Authorization" => token }

      expect(response).to have_http_status(:no_content)

      get "/en/api/v2/calculators.json", headers: { "Authorization" => token }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
