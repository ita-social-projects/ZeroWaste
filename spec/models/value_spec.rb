# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Value, type: :model do
  subject { create(:value) }
  describe 'validations' do
    it { is_expected.to validate_presence_of(:value) }
    it { is_expected.to allow_value('Value').for(:value) }
    it { is_expected.to validate_length_of(:value).is_at_least(1) }
    it { is_expected.not_to allow_value('.*+/+/').for(:value) }
  end
end
