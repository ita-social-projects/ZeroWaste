# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  subject { build(:product) }
  let(:localization_prefix) do
    'activerecord.errors.models.product.attributes'
  end
  describe 'validations' do
    it {
      is_expected.to validate_presence_of(:title)
        .with_message(I18n.t("#{localization_prefix}.title.blank"))
    }
    it {
      is_expected.to validate_length_of(:title).is_at_least(2)
                                               .with_message(I18n.t("#{localization_prefix}.title.too_short"))
    }
    it {
      is_expected.to validate_length_of(:title).is_at_most(50)
                                               .with_message(I18n.t("#{localization_prefix}.title.too_long"))
    }
  end
end
