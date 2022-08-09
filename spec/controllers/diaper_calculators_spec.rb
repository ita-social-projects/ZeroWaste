# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::DiaperCalculatorsController do
  describe '#create' do
    let(:values) do
      [
        { name: 'money_spent', result: 0 },
        { name: 'money_will_be_spent', result: 0 },
        { name: 'used_diapers_amount', result: 0 },
        { name: 'to_be_used_diapers_amount', result: 0 }
      ]
    end
    let(:expected) do
      { result: values,
        date: 0,
        word_form: 'підгузків' }.to_json
    end
    context 'when default values' do
      before do
        get :create
      end
      it 'renders expected result' do
        expect(response.body).to eq(expected)
      end
    end
  end
end
