# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:diaper) do
    Product.find_by(title: 'diaper')
  end
  describe 'factory' do
    context 'product prices factory not nil' do
      it 'low' do
        create(:product_price, category: 0)
        expect(ProductPrice.find_by(category: 'LOW', product: diaper)).not_to eq(nil)
      end
      it 'medium' do
        create(:product_price, category: 1)
        expect(ProductPrice.find_by(category: 'MEDIUM', product: diaper)).not_to eq(nil)
      end
      it 'high' do
        create(:product_price, category: 2)
        expect(ProductPrice.find_by(category: 'HIGH', product: diaper)).not_to eq(nil)
      end
    end
  end
end
