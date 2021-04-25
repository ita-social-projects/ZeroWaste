# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Calculators', type: :request do
  describe 'POST api/v1/calculators/PERMALINK/compute' do
    it 'returns JSON' do
      post '/api/v1/calculators/:id/compute'
      expect(response).to have_http_status(200)
    end
  end
end
