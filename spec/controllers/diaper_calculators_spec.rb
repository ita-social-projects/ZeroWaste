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
    let(:first) do
      ProductPrice.find_by(category: Api::V1::DiaperCalculatorsController::LOW, product: diaper)
    end
    let(:default) do
      ProductPrice.find_by(category: Api::V1::DiaperCalculatorsController::MEDIUM, product: diaper)
    end
    let(:last) do
      ProductPrice.find_by(category: Api::V1::DiaperCalculatorsController::HIGH, product: diaper)
    end
    let(:diaper) do
      Product.find_by(title: Api::V1::DiaperCalculatorsController::DIAPER_TITLE)
    end
    context 'when get value' do
      it 'first diaper price category returned' do
        create(:product_price, :LOW)

        controller.params[:price_id] = 0
        result = controller.send(:product_price)
        expect(result).not_to eq(nil)
        expect(result).to eq(first)
      end

      it 'default diaper price category returned' do
        create(:product_price, :MEDIUM)

        controller.params[:price_id] = 1
        result = controller.send(:product_price)
        expect(result).not_to eq(nil)
        expect(result).to eq(default)

        controller.params[:price_id] = -1
        result = controller.send(:product_price)
        expect(result).not_to eq(nil)
        expect(result).to eq(default)

        controller.params[:price_id] = nil
        result = controller.send(:product_price)
        expect(result).not_to eq(nil)
        expect(result).to eq(default)
      end

      it 'last diaper price category returned' do
        create(:product_price, :HIGH)

        controller.params[:price_id] = 2
        result = controller.send(:product_price)
        expect(result).not_to eq(nil)
        expect(result).to eq(last)
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
