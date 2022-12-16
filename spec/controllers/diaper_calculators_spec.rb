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
        word_form_to_be_used: 'підгузків',
        word_form_used: 'підгузків' }
    end
    context 'when default values' do
      before do
        get :create
      end

      it 'renders expected result' do
        expect(response.body).to eq(expected.to_json)
      end
    end
  end

  describe 'sending params to create' do
    let(:values) do
      [
        { name: 'money_spent', result: 12_718.5 },
        { name: 'money_will_be_spent', result: 10_614.0 },
        { name: 'used_diapers_amount', result: 2745.0 },
        { name: 'to_be_used_diapers_amount', result: 1830.0 }
      ]
    end
    let(:expected_result) do
      {
        result: values,
        date: 12,
        word_form_to_be_used: 'підгузків',
        word_form_used: 'підгузків'
      }
    end

    context 'when get awaited values' do
      include_context :app_config_load

      it 'got the expected result' do
        post :create, params: { childs_age: 12, locale: :uk }

        expect(response.body).to eq(expected_result.to_json)
        expect(response).to be_successful
      end
    end

    context 'when get unawaited values' do
      include_context :app_config_load

      let(:invalid_values) do
        [
          { name: 'money_spent', result: 42 },
          { name: 'money_will_be_spent', result: 42 },
          { name: 'used_diapers_amount', result: 42 },
          { name: 'to_be_used_diapers_amount', result: 42 }
        ]
      end

      it 'got the unexpected result' do
        expected_result[:result] = invalid_values
        post :create, params: { childs_age: 12 }

        expect(response.body).not_to eq(expected_result.to_json)
        expect(response).to be_successful
      end
    end
  end
end
