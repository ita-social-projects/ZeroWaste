# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::DiaperCalculatorsController do
  describe '#diaper_calc_communicator' do
    let(:values) do
      {
        money_spent: 0,
        money_will_be_spent: 0,
        used_diapers_amount: 0,
        to_be_used_diapers_amount: 0
      }
    end
    let(:expected) do
      { result: values,
        date: 0,
        word_form_to_be_used: 'підгузків',
        word_form_used: 'підгузків' }
    end
    context 'when default values' do
      before do
        get :diaper_calc_communicator
      end

      it 'renders expected result' do
        expect(response.body).to eq(expected.to_json)
      end
    end
  end

  describe 'sending params to diaper_calc_communicator' do
    let(:values) do
      {
        money_spent: 12_718.5,
        money_will_be_spent: 10_614.0,
        used_diapers_amount: 2745.0,
        to_be_used_diapers_amount: 1830.0
      }
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
        post :diaper_calc_communicator, params: { childs_age: 12 }

        expect(response.body).to eq(expected_result.to_json)
        expect(response).to be_successful
      end
    end

    context 'when get unawaited values' do
      include_context :app_config_load

      let(:invalid_values) do
        {
          money_spent: 42,
          money_will_be_spent: 42,
          used_diapers_amount: 42,
          to_be_used_diapers_amount: 42
        }
      end

      it 'got the unexpected result' do
        expected_result[:result] = invalid_values
        post :diaper_calc_communicator, params: { childs_age: 12 }

        expect(response.body).not_to eq(expected_result.to_json)
        expect(response).to be_successful
      end
    end
  end
end
