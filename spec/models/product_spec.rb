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

RSpec.describe Product, type: :model do
  let(:local_prefix_product) { "activerecord.errors.models.product.attributes" }

  subject { build(:product) }

  describe "associations" do
    it { is_expected.to have_many(:prices).dependent(:destroy) }

    it { is_expected.to have_many(:categories_by_prices).through(:prices).source(:category) }
  end

  describe "validations" do
    it "validates the title and message " do
      is_expected.to validate_presence_of(:title)
        .with_message(I18n.t("#{local_prefix_product}.title.blank"))
    end

    it "validates the title's length and message" do
      is_expected.to validate_length_of(:title).is_at_least(2)
                                               .with_message(I18n.t("#{local_prefix_product}.title.too_short", count: 2))

      is_expected.to validate_length_of(:title).is_at_most(30)
                                               .with_message(I18n.t("#{local_prefix_product}.title.too_long", count: 30))
    end

    it "validates the title's uniqueness and message " do
      is_expected.to validate_uniqueness_of(:title)
        .with_message(I18n.t("#{local_prefix_product}.title.taken"))
    end

    context "validates the title format" do
      let(:product) { build(:product) }

      it "with valid title" do
        product.title = "Hedgehog і єнот з'їли 2 аґруси"

        expect(product).to be_valid
      end

      it "with invalid title" do
        ["#", "!", "@", "$", "%", "^", "&", "*", "(", ")", "?", "\"", "_"].each do |sym|
          product.title = "Invalid Title #{sym}"

          expect(product).to_not be_valid
          expect(product.errors.messages[:title]).to include(I18n.t("#{local_prefix_product}.title.invalid"))
        end
      end
    end
  end

  describe "#price_by_category" do
    let(:product) { create(:product, title: "Valid Title") }
    let(:category) { create(:category, :medium) }
    let(:valid_sum) { 10.0 }

    context "when the product has a price for the category" do
      let!(:existing_price) { create(:price, priceable: product, category: category, sum: valid_sum) }

      it "returns the price for the specified category" do
        expect(product.price_by_category(category)).to eq(existing_price)
      end
    end

    context "when the product does not have a price for the category" do
      it "returns nil" do
        expect(product.price_by_category(category)).to be_nil
      end
    end
  end

  describe "#find_or_build_price_for_category" do
    let(:product) { create(:product, title: "Valid Title") }
    let(:category) { create(:category, :medium) }
    let(:valid_sum) { 10.0 }

    context "when the product has a price for the category" do
      let!(:existing_price) { create(:price, priceable: product, category: category, sum: valid_sum) }

      it "returns the existing price" do
        expect(product.find_or_build_price_for_category(category)).to eq(existing_price)
      end
    end

    context "when the product does not have a price for the category" do
      let(:new_price) { product.find_or_build_price_for_category(category) }

      it "builds a new price for the category" do
        expect(product.prices).to be_empty
        expect(new_price.category).to eq(category)
        expect(new_price).to be_a_new(Price)
      end
    end
  end

  describe ".diaper" do
    let!(:diaper_product) { create(:product, title: "diaper") }
    let!(:other_product) { create(:product, title: "shampoo") }

    it "returns the product with title 'diaper'" do
      expect(Product.diaper).to eq(diaper_product)
    end

    it "does not return a product with a different title" do
      expect(Product.diaper).not_to eq(other_product)
    end
  end

  describe "#blank_prices" do
  let(:diaper_product) { create(:product, :diaper, prices_attributes: [{ sum: 50, category: create(:category) }]) }
  let(:invalid_product) { build(:product, prices_attributes: [{ sum: nil, category: create(:category) }]) }
    
    context "when price sum is blank" do
      it "rejects nested attributes for price" do
        expect(invalid_product.prices).to be_empty
      end
    end

    context "when price sum is present" do
      it "accepts nested attributes for price" do
        expect(diaper_product.prices.size).to eq(1)
      end
    end
  end
end
