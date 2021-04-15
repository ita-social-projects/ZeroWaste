# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RangeField, type: :model do
  subject { create(:range_field) }
  describe 'validations' do
    it { is_expected.to validate_presence_of(:from) }
    it { is_expected.to validate_presence_of(:to) }
    it { is_expected.to validate_presence_of(:value) }
    it { is_expected.to validate_numericality_of(:from).only_integer }
    it { is_expected.to validate_numericality_of(:to).only_integer }
    it {
      is_expected.to validate_length_of(:value)
        .is_at_least(1)
    }
  end
end
