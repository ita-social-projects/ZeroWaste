# frozen_string_literal: true

# == Schema Information
#
# Table name: app_configs
#
#  id                 :bigint           not null, primary key
#  diapers_calculator :jsonb
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
require "rails_helper"

RSpec.describe AppConfig, type: :model do
  context "is a singleton model" do
    it "should not allow using new method" do
      expect { AppConfig.new }.to raise_error NoMethodError
    end
    it "should have instance method" do
      expect(AppConfig.instance).to be_an AppConfig
    end
  end
end
