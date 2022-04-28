require 'rails_helper'

RSpec.describe '/api/v1/calculators', type: :request do
  let(:json_response) { JSON.parse(response.body) }
  describe 'POST api/v1/calculators/PERMALINK/compute' do
    before do
      post "/api/v1/calculators/PERMALINK/compute"
    end

    it 'returns http success' do
      expect(response.status).to eq(200)
    end

    it 'returns JSON data correctly' do
      expect(json_response)
        .to eq(
              'result' => [
                { 'name' => 'bought_diapers', 'result' => 8956 },
                { 'name' => 'money_spent', 'result' => 7841 },
                { 'name' => 'garbage_created', 'result' => 342 }
              ]
            )
    end

    it 'JSON contains response' do
      expect(json_response).to be_truthy
    end
  end
end
