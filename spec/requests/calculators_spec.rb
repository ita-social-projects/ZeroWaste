# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Calculators', type: :request do
  let(:calculator) { create(:calculator) }
  describe 'POST api/v1/calculators/PERMALINK/compute' do
    it 'returns JSON' do
      post compute_api_v1_calculator_path(calculator)
      expect(response).to have_http_status(200)
    end
  end
end
