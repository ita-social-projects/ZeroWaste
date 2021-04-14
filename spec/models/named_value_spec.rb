require 'rails_helper'

RSpec.describe NamedValue, type: :model do
  subject { build(:named_value) }
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(2) }
  end
end
