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
#  idx_on_category_id_priceable_id_priceable_type_1fa9ce7f24  (category_id,priceable_id,priceable_type) UNIQUE
#  index_prices_on_category_id                                (category_id)
#  index_prices_on_priceable                                  (priceable_type,priceable_id)
#
require "rails_helper"

RSpec.describe Price, type: :model do
  subject { create(:price, :budgetary_price) }

  describe "associations" do
    it { is_expected.to belong_to(:priceable) }

    it { is_expected.to belong_to(:category).optional }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:sum) }

    it { is_expected.to validate_numericality_of(:sum).is_greater_than_or_equal_to(0) }

    it { is_expected.to validate_numericality_of(:sum).is_less_than(1_000_000) }

    it { is_expected.to validate_uniqueness_of(:category_id).scoped_to(:priceable_id, :priceable_type) }

    it { is_expected.to validate_uniqueness_of(:priceable_id).scoped_to(:category_id, :priceable_type) }
  end

  describe "validations" do
    let(:budgetary_price) { build(:price, :budgetary_price) }
    let(:medium_price) { build(:price, :medium_price) }
    let(:product_diaper) do
      create(:product, :diaper, prices: [budgetary_price])
    end
    let(:product_napkin) do
      create(:product, :napkin, prices: [budgetary_price, medium_price])
    end

    context "when a sum of price will presence" do
      it { is_expected.to validate_presence_of(:sum) }
    end

    context "when a product(diaper) has one price" do
      it "returns valid product" do
        expect(product_diaper).to be_valid
      end
    end

    context "when a product(diaper) can have many different prices" do
      it "returns valid product" do
        expect(product_napkin).to be_valid
      end
    end

    context "when a product(napkin) can have the same sums as a product(diaper)" do
      let(:product_diaper) do
        create(:product, :diaper, prices: [budgetary_price, medium_price])
      end

      include_examples "compare categories"
    end

    context "with two identical prices and the same category a product(diaper)" do
      it "is invalid" do
        product_diaper.prices.build(budgetary_price.attributes)

        expect(product_diaper).not_to be_valid
      end
    end
  end
end
