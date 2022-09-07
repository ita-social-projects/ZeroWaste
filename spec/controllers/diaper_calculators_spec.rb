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
    context 'when default value' do
      it 'custom diaper price category selected' do
        controller.params[:price_id] = 0
        diaper = Product.find_by title: 'diaper'
        expect(controller.send(:product_price)).to eq(ProductPrice.find_by category: 0, product: diaper)
      end

      it 'default diaper price category selected' do
        controller.params[:price_id] = 1
        diaper = Product.find_by title: 'diaper'
        expect(controller.send(:product_price)).to eq(ProductPrice.find_by category: 1, product: diaper)
      end

      it 'incorrect diaper price category selected' do
        controller.params[:price_id] = -1
        diaper = Product.find_by title: 'diaper'
        expect(controller.send(:product_price)).to eq(ProductPrice.find_by category: 1, product: diaper)
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
