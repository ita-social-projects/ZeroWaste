# frozen_string_literal: true

# == Schema Information
#
# Table name: product_prices
#
#  id         :bigint           not null, primary key
#  category   :integer
#  price      :float
#  uuid       :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#
# Indexes
#
#  index_product_prices_on_product_id  (product_id)
#  index_product_prices_on_uuid        (uuid) UNIQUE
#
require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'factory' do
    context 'product prices factory not nil' do
      it 'budgetary' do
        expect(create(:product_price, :budgetary)).not_to be_nil
      end
      it 'medium' do
        expect(create(:product_price, :medium)).not_to be_nil
      end
      it 'premium' do
        expect(create(:product_price, :premium)).not_to be_nil
      end
    end
  end
end
