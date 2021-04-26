# frozen_string_literal: true

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
    fjkghtrkjhk5jhksjfghiluserhgiuerhgiufdhfjdsbmnvbd nnvbjrhgfbjhrfgulerhkgj.dnsbhmvbdhfgbhqrejgeklfhil4otuu
  end
end
