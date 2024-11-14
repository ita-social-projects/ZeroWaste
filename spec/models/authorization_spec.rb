require "rails_helper"

RSpec.describe Authorization, type: :model do
  let(:authorization) { FactoryBot.build :authorization }

  describe "associations" do
    it { is_expected.to belong_to(:admin).class_name("User").with_foreign_key("uid").optional }
  end
end
