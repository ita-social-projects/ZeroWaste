# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id              :bigint           not null, primary key
#  uuid            :uuid             not null
#  title           :string
#  product_type_id :bigint
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'
LOCAL_PREFIX_PRODUCT = 'activerecord.errors.models.product.attributes'

RSpec.describe Product, type: :model do
  subject { build(:product) }
  describe 'validations' do
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
