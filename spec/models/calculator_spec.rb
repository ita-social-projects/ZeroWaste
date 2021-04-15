# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Calculator, type: :model do
  subject { build(:calculator) }
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it {
      is_expected.to validate_length_of(:name)
        .is_at_least(2)
        .on(:create)
    }
    it { is_expected.not_to allow_value('Hh34').for(:name) }
  end
end
