# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::CalculatorsController, type: :request do
  let(:calculator) { create(:calculator) }
  let!(:calculation_r1) do
    create(:calculation, value: 'P2 + P1 ', type: 'Calculation', selector: 'R1',
                         name: 'First result', label: 'one', kind: 'result',
                         calculator: calculator)
  end
  let!(:calculation_r2) do
    create(:calculation, value: '10 + P4 ', type: 'Calculation', selector: 'R2',
                         name: 'Second result', label: 'one', kind: 'result',
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
  let(:value) { CalculationResolver.new }
  let(:parameters) { CalculationResolver.new }
  let(:calculation) { create(:calculation, value: value) }
  subject  { CalculationResolver.result(parameters, calculation.value) }

  describe 'POST api/v1/calculators/PERMALINK/compute' do
    before do
      post compute_api_v1_calculator_path(calculator)
    end
    it 'http 200' do
      expect(response.status).to eql(200)
    end

    context 'when Value is calculation_r1,parameters is value_p1, value_p2 ' do
      let(:value) { calculation_r1[:value] }
      let(:parameters) do
        { value_p1[:selector] => value_p1[:value],
          value_p2[:selector] => value_p2[:value] }
      end
      it { is_expected.to eq 30 }
    end

    context 'when Value is calculation_r2 , result to be nil ' do
      let(:value) { calculation_r2[:value] }
      let(:parameters) { { value_p1[:selector] => value_p1[:value] } }
      it { is_expected.to be_nil }
    end
  end
end
