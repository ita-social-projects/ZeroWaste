require 'rails_helper'

RSpec.describe Calculator, type: :model do
  before { build(:calculator) }
  describe 'associations' do
    it { should have_many(:fields)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).
              is_at_least(2).
              on(:create) }
    it { should_not allow_value("Hh34").for(:name) }
  end
end
