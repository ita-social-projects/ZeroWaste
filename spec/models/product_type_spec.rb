# frozen_string_literal: true

# == Schema Information
#
# Table name: product_types
#
#  id         :bigint           not null, primary key
#  title      :string
#  uuid       :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_product_types_on_uuid  (uuid) UNIQUE
#
require "rails_helper"

LOCAL_PREFIX_PRIDUCT_TYPE = "activerecord.errors.models.product_type.attributes"

RSpec.describe ProductType, type: :model do
  subject { build(:product_type) }

  describe "associations" do
    it { is_expected.to have_many(:products).dependent(:destroy) }
  end

  describe "validations" do
    it {
      is_expected.to validate_presence_of(:title).with_message(I18n
        .t("#{LOCAL_PREFIX_PRIDUCT_TYPE}.title.blank"))
    }
    it { is_expected.to allow_value("Ab2").for(:title) }
    it {
      is_expected.to validate_length_of(:title).is_at_least(3).with_message(I18n
        .t("#{LOCAL_PREFIX_PRIDUCT_TYPE}.title.too_short"))
    }
    it {
      is_expected.not_to allow_value(".*+/+/").for(:title).with_message(I18n
        .t("#{LOCAL_PREFIX_PRIDUCT_TYPE}.title.invalid"))
    }
  end
end
