# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Select, type: :model do
  subject { create(:select) }
  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:value) }
    it { is_expected.to validate_length_of(:value).is_at_least(2) }
  end
end
