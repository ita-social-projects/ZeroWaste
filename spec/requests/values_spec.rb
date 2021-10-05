require 'rails_helper'

RSpec.describe 'Values', type: :request do
  let(:json_response) { JSON.parse(response.body) }
  describe 'POST api/v1/calculators/PERMALINK/compute' do
    before do
      post "/api/v1/calculators/PERMALINK/compute"
    end

    it 'returns http success' do
      expect(response.status).to eq(200)
    end

    it 'returns JSON data correctly' do
      expect(json_response).to eq({"bought_diapers"=>8956, "money_spent"=>7841, "garbage_created"=>342})
    end

    it 'JSON contains response' do
      expect(json_response).to be_truthy
    end
  end
end
