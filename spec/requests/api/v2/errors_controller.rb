require "rails_helper"

RSpec.describe Api::V2::ErrorsController, type: :request do
  let(:invalid_locale) { :invalid_locale }

  describe "#invalid_locale" do
    it "returns a bad request response with an error message" do
      post "/#{invalid_locale}/api/v2/diaper_calculators"

      expect(response.body).to eq({ error: "Locale not supported" }.to_json)
    end
  end
end
