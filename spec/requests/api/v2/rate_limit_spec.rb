require "rails_helper"

RSpec.describe "Rate limiting", type: :request do
  let(:user) { create(:user) }
  let(:token) { Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first }
  let(:headers) { { "Authorization" => "Bearer #{token}" } }

  it "limits requests to 5 per minute" do
    5.times do
      get "/en/api/v2/calculators.json", headers: headers

      expect(response).to be_ok
    end

    get "/en/api/v2/calculators.json", headers: headers

    expect(response).to be_too_many_requests
    expect(response.parsed_body["error"]).to match(/Rate limit exceeded/)
  end
end
