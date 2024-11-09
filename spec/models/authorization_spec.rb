require "rails_helper"

RSpec.describe Authorization, type: :model do
  context "associations" do
    it { is_expected.to belong_to(:admin).optional }
  end
end
