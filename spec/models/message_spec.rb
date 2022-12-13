# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  message    :string           not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe Message, type: :model do
  let!(:message) { build(:message) }

  describe "validations" do
    it { is_expected.to validate_length_of(:title).is_at_least(5) }
    it { is_expected.to allow_value("test@test.com").for(:email) }
    it { is_expected.to validate_length_of(:message).is_at_least(20) }
  end
end
