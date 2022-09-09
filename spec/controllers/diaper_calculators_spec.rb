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

  describe '#product_price' do
    let(:diaper) do
      Product.find_by(title: 'diaper')
    end
    let(:default) do
      ProductPrice.find_by(category: 'MEDIUM', product: diaper)
    end
    context 'when get value' do
      it 'custom diaper price category selected' do
        controller.params[:price_id] = 0
        expect(controller.send(:product_price)).to eq(ProductPrice.find_by(category: 'LOW', product: diaper))
      end

      it 'default diaper price category selected' do
        controller.params[:price_id] = 1
        expect(controller.send(:product_price)).to eq(default)
      end

      it 'incorrect diaper price category selected' do
        controller.params[:price_id] = -1
        expect(controller.send(:product_price)).to eq(default)
      end

      it 'void parameter sended' do
        controller.params[:price_id] = nil
        expect(controller.send(:product_price)).to eq(default)
      end
    end
  end

  describe '#childs_age' do
    context 'when default value' do
      it 'child`s age selected' do
        controller.params[:childs_age] = 1
        expect(controller.send(:childs_age)).to eq(1)
      end
    end
  end
end
