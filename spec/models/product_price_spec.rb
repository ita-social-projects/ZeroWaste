# frozen_string_literal: true

require 'rails_helper'

LOW = 'LOW'
MEDIUM = 'MEDIUM'
HIGH = 'HIGH'

RSpec.describe Product, type: :model do
  let(:diaper) do
    Product.find_by(title: 'diaper')
  end
  describe 'factory' do
    context 'product prices factory not nil' do
      it 'low' do
        create(:product_price, :LOW)
        expect(ProductPrice.find_by(category: LOW, product: diaper)).not_to eq(nil)
      end
      it 'medium' do
        create(:product_price, :MEDIUM)
        expect(ProductPrice.find_by(category: MEDIUM, product: diaper)).not_to eq(nil)
      end
      it 'high' do
        create(:product_price, :HIGH)
        expect(ProductPrice.find_by(category: HIGH, product: diaper)).not_to eq(nil)
      end
    end
  end
end
