# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  subject { build(:product) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_least(2).is_at_most(50) }
  end
end
