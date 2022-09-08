# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  let!(:product_price) { create(:product_price) }
  let(:diaper) do
    Product.find_by(title: 'diaper')
  end
  describe 'factory' do
    context 'product prices factory not nil' do
      it 'low' do
        expect(ProductPrice.find_by(category: 'LOW', product: diaper)).not_to eq(nil)
      end
      it 'medium' do
        expect(ProductPrice.find_by(category: 'MEDIUM', product: diaper)).not_to eq(nil)
      end
      it 'high' do
        expect(ProductPrice.find_by(category: 'HIGH', product: diaper)).not_to eq(nil)
      end
      it 'count' do
        expect(ProductPrice.count).not_to eq(0)
      end
    end
  end
end
