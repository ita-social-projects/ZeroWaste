# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductType, type: :model do
  subject { build(:product_type) }
  describe 'validations' do
    it {
      is_expected.to validate_presence_of(:title).with_message(I18n.t('activerecord.errors.models.product_type.attributes.title.blank'))
    }
    it { is_expected.to allow_value('Ab2').for(:title) }
    it {
      is_expected.to validate_length_of(:title).is_at_least(3)
                                               .with_message(I18n.t('activerecord.errors.models.product_type.attributes.title.too_short'))
    }
    it {
      is_expected.not_to allow_value('.*+/+/').for(:title).with_message(I18n.t('activerecord.errors.models.product_type.attributes.title.invalid'))
    }
  end
end
