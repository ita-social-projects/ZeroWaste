require 'rails_helper'

RSpec.describe Calculators::DiapersService, type: :service do
  subject { described_class }
  context 'when age valid' do
    let(:service) { described_class.new((Time.now - 36_892_800).strftime("%Y-%m-%d")).calculate! }
    it 'calculates price and amount of diapers' do
      expect(service.used_diapers_amount).to eq 2989
      expect(service.used_diapers_price).to eq 14_060.5
      expect(service.to_be_used_diapers_amount).to eq 1586
      expect(service.to_be_used_diapers_price).to eq 9272
    end
  end
end
