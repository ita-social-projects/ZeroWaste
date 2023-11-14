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

  context "calls a service method" do
    let(:app_config_instance) { AppConfig.instance }
    let(:diapers_calculator_params) { attributes_for(:diapers_calculator_params) }
    let(:updated_diapers_calculator) { attributes_for(:app_config, :updated) }

    it "updates the AppConfig instances diapers calculator" do
      app_config_instance.update_diapers_calculator(diapers_calculator_params)

      expect(app_config_instance[:diapers_calculator]).to eq(updated_diapers_calculator[:diapers_calculator])
    end

    it "receives product attributes" do
      allow(Calculators::DiapersService).to receive(:product_attributes).with(
        diapers_calculator_params
      )
      app_config_instance.update_diapers_calculator(diapers_calculator_params)

      expect(Calculators::DiapersService).to have_received(:product_attributes).with(
        diapers_calculator_params
      )
    end
  end
end
