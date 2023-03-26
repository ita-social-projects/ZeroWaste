# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id              :bigint           not null, primary key
#  title           :string
#  uuid            :uuid             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  product_type_id :bigint
#
# Indexes
#
#  index_products_on_product_type_id  (product_type_id)
#  index_products_on_uuid             (uuid) UNIQUE
#
require "rails_helper"

LOCAL_PREFIX_PRODUCT = "activerecord.errors.models.product.attributes"

RSpec.describe Product, type: :model do
  let!(:product) { build(:product) }

  describe "associations" do
    it { is_expected.to belong_to(:product_type).optional }

    it { is_expected.to have_many(:category_categoryables).dependent(:destroy) }

    it { is_expected.to have_many(:categories).through(:category_categoryables) }

    it { is_expected.to have_many(:prices).dependent(:destroy) }
  end

  describe "validations" do
    it {
      is_expected.to validate_presence_of(:title)
        .with_message(I18n.t("#{LOCAL_PREFIX_PRODUCT}.title.blank"))
    }
    it {
      is_expected.to validate_length_of(:title).is_at_least(2).with_message(I18n
        .t("#{LOCAL_PREFIX_PRODUCT}.title.too_short"))
    }
    it {
      is_expected.to validate_length_of(:title).is_at_most(50).with_message(I18n
        .t("#{LOCAL_PREFIX_PRODUCT}.title.too_long"))
    }
  end

  describe "#blank_prices" do
    let!(:blank_price_attributes) { attributes_for(:price, sum: "") }
    let!(:price_attributes) { attributes_for(:price, sum: :budgetary_price) }

    it "returns true when the sum attribute is blank" do
      expect(product.blank_prices(blank_price_attributes)).to be_truthy
    end

    it "returns false when the sum attribute is present" do
      expect(product.blank_prices(price_attributes)).to be_falsy
    end
  end
end
