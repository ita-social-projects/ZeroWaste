require 'rails_helper'

RSpec.describe Calculators::CalculationService do
  describe '#perform' do
    let(:calculator) { create(:calculator) }
    let(:inputs) { ActionController::Parameters.new(a: 10, b: 2) }

    it 'calculates results based on the provided inputs' do
      service = described_class.new(calculator, inputs)
      results = service.perform

      expect(results).to eq([
        { label: 'Sum', result: 12 },
        { label: 'Product', result: 20 }
      ])
    end
  end
end
