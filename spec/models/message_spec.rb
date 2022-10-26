# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message, type: :model do
  let!(:message) { build(:message) }
  describe 'validations' do
    it { is_expected.to validate_length_of(:title).is_at_least(5) }
    it { is_expected.to allow_value('test@test.com').for(:email) }
    it { is_expected.to validate_length_of(:message).is_at_least(20) }
  end
end
