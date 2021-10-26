# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::CalculatorsController, type: :request do
  let(:calculator) { create(:calculator) }
  let(:json_response) { JSON.parse(response.body) }

  describe 'POST api/v1/calculators/PERMALINK/compute' do
    before do
      post compute_api_v1_calculator_path(calculator)
    end
    it 'http 200' do
      expect(response.status).to eql(200)
    end
    it 'result of calculation_r1 is 20' do
      expect(json_response['result'][0]['result']).to eq(20)
      expect(json_response['result'][0].values).to contain_exactly(
        'first_result', 20
      )
    end
    it 'result of calculation_r2 is 70' do
      expect(json_response['result'][1]['result']).to eq(70)
      expect(json_response['result'][1].values).to contain_exactly(
        'second_result', 70
      )
    end
    it 'result of calculation_r3 is 30' do
      expect(json_response['result'][2]['result']).to eq(30)
      expect(json_response['result'][2].values).to contain_exactly(
        'third_result', 30
      )
    end
    it do
      expect(json_response['result'][0]['result']).to be_kind_of(Numeric)
    end
  end
end
