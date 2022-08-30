# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Calculators::DiapersService, type: :service do
  subject { described_class }
  before(:each) do
    @service = build(:diapers_service).calculate!
  end
  context 'when age valid' do
    it 'calculates price and amount of diapers' do
      expect(@service.used_diapers_amount).to eq 2013
      expect(@service.to_be_used_diapers_amount).to eq 2562
      expect(@service.used_diapers_price).to eq 8784
      expect(@service.to_be_used_diapers_price).to eq 14_548.5
    end
  end
end
