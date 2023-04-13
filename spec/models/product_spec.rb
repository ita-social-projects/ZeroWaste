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
  subject(:product) { build(:product) }

  describe "associations" do
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
end
