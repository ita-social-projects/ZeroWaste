require 'rails_helper'

RSpec.describe Calculators::PreferableService do
  let!(:calculator1) { Calculator.create!(name: "calculator1", slug: 'calculator1', preferable: true) }
  let!(:calculator2) { Calculator.create!(name: "calculator2", slug: 'calculator2', preferable: true) }
  let!(:calculator3) { Calculator.create!(name: "calculator3", slug: 'calculator3', preferable: false) }

  describe '#perform!' do
    context 'when preferable is set to 1' do
      it 'updates other calculators to have preferable set to false' do
        service = Calculators::PreferableService.new(preferable: 1, slug: calculator1.slug)
        service.perform!

        expect(calculator1.reload.preferable).to eq(true)
        expect(calculator2.reload.preferable).to eq(false)
        expect(calculator3.reload.preferable).to eq(false)
      end
    end

    context 'when preferable is not set to 1' do
      it 'does not change any preferable values' do
        service = Calculators::PreferableService.new(preferable: 0, slug: 'calculator1')
        service.perform!

        expect(calculator1.reload.preferable).to eq(true)
        expect(calculator2.reload.preferable).to eq(true)
        expect(calculator3.reload.preferable).to eq(false)
      end
    end
  end
end
