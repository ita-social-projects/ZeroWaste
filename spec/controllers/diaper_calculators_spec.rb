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
        word_form: 'підгузків' }
    end
    context 'when default values' do
      before do
        get :create
      end
      it 'renders expected result' do
        expect(response.body).to eq(expected.to_json)
      end
      it 'diaper price category selected' do
        allow(product_price).to receive(1).and_return(ProductPrice.first)
      end
    end
  end
end
