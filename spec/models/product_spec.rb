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
  subject { build(:product) }

  describe "associations" do
    it { is_expected.to have_many(:prices).dependent(:destroy) }

    it { is_expected.to have_many(:categories_by_prices).through(:prices).source(:category) }

    it { is_expected.to have_many(:prices).dependent(:destroy) }
  end

  describe "validations" do
    it "validates the title and message " do
      is_expected.to validate_presence_of(:title)
        .with_message(I18n.t("#{LOCAL_PREFIX_PRODUCT}.title.blank"))
    end

    it "validates the title's length and message" do
      is_expected.to validate_length_of(:title).is_at_least(2)
                                               .with_message(I18n.t("#{LOCAL_PREFIX_PRODUCT}.title.too_short", count: 2))

      is_expected.to validate_length_of(:title).is_at_most(30)
                                               .with_message(I18n.t("#{LOCAL_PREFIX_PRODUCT}.title.too_long", count: 30))
    end

    it "validates the title's uniqueness and message " do
      is_expected.to validate_uniqueness_of(:title)
        .with_message(I18n.t("#{LOCAL_PREFIX_PRODUCT}.title.taken"))
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
          expect(product.errors.messages[:title]).to include(I18n.t("#{LOCAL_PREFIX_PRODUCT}.title.invalid"))
        end
      end
    end
  end
end
