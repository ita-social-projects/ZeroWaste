# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductType, type: :model do
  subject { build(:product_type) }
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to allow_value('Ab2').for(:title) }
    it { is_expected.to validate_length_of(:title).is_at_least(3) }
    it { is_expected.not_to allow_value('.*+/+/').for(:title) }
  end
end
