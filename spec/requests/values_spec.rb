require 'rails_helper'

RSpec.describe "Values", type: :request do
  describe "POST /api/v1" do
    it "returns http success" do
      get "/api/v1/calculators/PERMALINK/compute"

      expect(response.body).to eq('{"bought_diapers":8956,"money_spent":7841,"garbage_created":342}')

      expect(response.status).to eq(200)
    end
  end
end
