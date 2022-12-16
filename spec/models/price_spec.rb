# frozen_string_literal: true

# == Schema Information
#
# Table name: prices
#
#  id             :bigint           not null, primary key
#  priceable_type :string
#  sum            :decimal(8, 2)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  category_id    :integer
#  priceable_id   :bigint
#
# Indexes
#
#  index_prices_on_category_id  (category_id)
#  index_prices_on_priceable    (priceable_type,priceable_id)
#
require 'rails_helper'

RSpec.describe Price, type: :model do
  include GlobalHelpers

  describe 'validations' do
    let(:budgetary_price) { build(:price, :budgetary_price) }
    let(:medium_price) { build(:price, :medium_price) }
    let(:product_diaper) { create(:product, :diaper, prices: [budgetary_price]) }
    let(:product_napkin) { create(:product, :napkin, prices: [budgetary_price, medium_price]) }
    # let(:resource) { create(:resource) }

    context 'when a product(diaper) has one price' do
      it 'returns valid product' do

        expect(product_diaper).to be_valid
      end
    end

    context 'when a product(diaper) can have many different prices' do
      it 'returns valid product' do

        expect(product_napkin).to be_valid
      end
    end

    context 'when a product(napkin) can have the same sums as a product(diaper)' do
      let(:product_diaper) { create(:product, :diaper, prices: [budgetary_price, medium_price]) }

      it 'returns valid product' do
        compare_fields(product_diaper.prices.first, product_napkin.prices.first, [:id, :sum])
        compare_fields(product_diaper.prices.last, product_napkin.prices.last, [:id, :sum])
      end
    end

    skip 'is skipped' do
      context 'when a resource model can have the same prices as a product model' do
        it 'returns valid product' do

          expect(product_napkin).to be_valid
          expect(resource).to be_valid
        end
      end
    end

    context 'when a product(diaper) cannot have two identical prices' do
      it 'returns invalid product' do
        product_diaper.prices.build(budgetary_price.attributes)

        expect(product_diaper).not_to be_valid
      end
    end
  end
end
