# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RangeField, type: :model do
  subject { create(:range_field) }
  describe 'validations' do
    it { is_expected.to validate_presence_of(:from)
    .with_message(I18n.t('activerecord.errors.models.range_field.attributes.from.blank')) 
      }
    it { is_expected.to validate_presence_of(:to)
    .with_message(I18n.t('activerecord.errors.models.range_field.attributes.to.blank')) 
      }
    it { is_expected.to validate_presence_of(:value)
        .with_message(I18n.t('activerecord.errors.models.range_field.attributes.value.blank')) 
      }
    it { is_expected.to validate_numericality_of(:from).only_integer
    #.with_message(I18n.t('activerecord.errors.models.range_field.attributes.from.not_an_integer'))
      }
    it { is_expected.to validate_numericality_of(:to).only_integer 
    #.with_message(I18n.t('activerecord.errors.models.range_field.attributes.to.not_an_integer'))
      }
    it {
      is_expected.to validate_length_of(:value)
        .is_at_least(1)
        .with_message(I18n.t('activerecord.errors.models.range_field.attributes.value.too_short')) 
      }
  
  end
end
