# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::CalculatorsController, type: :request do
  let(:calculator) { create(:calculator) }
  let!(:calculation_r1) do
    create(:calculation, value: 'P1 + 10', type: 'Calculation', selector: 'R1',
                         name: 'First result', label: 'one', kind: 'result',
                         calculator: calculator)
  end
  let!(:calculation_r2) do
    create(:calculation, value: '10 + P4 ', type: 'Calculation', selector: 'R2',
                         name: 'Second result', label: 'one', kind: 'result',
                         calculator: calculator)
  end
  let!(:calculation_r3) do
    create(:calculation, value: '10 + P2 ', type: 'Calculation', selector: 'R3',
           name: 'Third result', label: 'one', kind: 'result',
           calculator: calculator)
  end
  let!(:value_p1) do
    create(:value, value: '10', type: 'Value', selector: 'P1', label: 'one',
                   kind: 'parameter',
                   calculator: calculator)
  end
  let!(:value_p2) do
    create(:value, value: '20', type: 'Value', selector: 'P2', label: 'two',
                   kind: 'parameter',
                   calculator: calculator)
  end
  let!(:value_p3) do
    create(:value, value: '50', type: 'Value', selector: 'P3', label: 'three',
                   kind: 'parameter',
                   calculator: calculator)
  end
  let!(:value_p4) do
    create(:value, value: '60', type: 'Value', selector: 'P4', label: 'four',
                   kind: 'parameter',
                   calculator: calculator)
  end
  let(:json_response) { JSON.parse(response.body) }
  describe 'POST api/v1/calculators/PERMALINK/compute' do
    before do
      post compute_api_v2_calculator_path(calculator)
    end
    it 'http 200' do
      expect(response.status).to eql(200)
    end
    it 'result of calculation_r1 is 30' do
      expect(json_response['result'][0]['result']).to eq(20)
    end
    it 'result of calculation_r2 is 70' do
      expect(json_response['result'][1]['result']).to eq(70)
    end
    it 'result of calculation_r2 is 70' do
      expect(json_response['result'][2]['result']).to eq(30)
    end
    it do
      expect(json_response['result'][0]['result']).to be_kind_of(Numeric)
    end
  end
end
