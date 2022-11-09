# frozen_string_literal: true

# == Schema Information
#
# Table name: product_prices
#
#  id         :bigint           not null, primary key
#  uuid       :uuid             not null
#  product_id :bigint           not null
#  price      :float
#  category   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'factory' do
    context 'product prices factory not nil' do
      it 'low' do
        expect(create(:product_price, :LOW)).not_to eq(nil)
      end
      it 'medium' do
        expect(create(:product_price, :MEDIUM)).not_to eq(nil)
      end
      it 'high' do
        expect(create(:product_price, :HIGH)).not_to eq(nil)
      end
    end
  end
end
