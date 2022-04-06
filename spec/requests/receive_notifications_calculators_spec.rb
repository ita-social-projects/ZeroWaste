require 'rails_helper'

RSpec.describe "Calculators", type: :request do
  describe "POST /receive_recomendations" do
    it "returns http success" do
      post "/receive_recomendations"
      expect(response).to have_http_status(:success)
    end
  end
end
