# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:diaper) do
    Product.find_by(title: Api::V1::DiaperCalculatorsController::DIAPER_TITLE)
  end
  describe 'factory' do
    context 'product prices factory not nil' do
      it 'low' do
        create(:product_price, :LOW)
        expect(ProductPrice.find_by(category: Api::V1::DiaperCalculatorsController::LOW, product: diaper)).not_to eq(nil)
      end
      it 'medium' do
        create(:product_price, :MEDIUM)
        expect(ProductPrice.find_by(category: Api::V1::DiaperCalculatorsController::MEDIUM, product: diaper)).not_to eq(nil)
      end
      it 'high' do
        create(:product_price, :HIGH)
        expect(ProductPrice.find_by(category: Api::V1::DiaperCalculatorsController::HIGH, product: diaper)).not_to eq(nil)
      end
    end
  end
end
