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
    # let(:diapers_service) { instance_double(Calculators::DiapersService) }
    let(:params) do
      {
        "1..3" => { "price" => "7.5", "amount" => "10" },
        "4..6" => { "price" => "9.5", "amount" => "8" },
        "7..9" => { "price" => "9", "amount" => "6" },
        "10..12" => { "price" => "10.5", "amount" => "6" },
        "13..18" => { "price" => "10.5", "amount" => "4" },
        "19..24" => { "price" => "12.5", "amount" => "4" },
        "25..30" => { "price" => "12.5", "amount" => "2" }
      }
    end

    let(:invalid_params) do
      {
        "1" => { "price" => "7.5", "amount" => "10" },
        "2" => { "price" => "9.5", "amount" => "8" },
        "3" => { "price" => "9", "amount" => "6" },
        "4" => { "price" => "10.5", "amount" => "6" },
        "5" => { "price" => "10.5", "amount" => "4" },
        "6" => { "price" => "12.5", "amount" => "4" },
        "7" => { "price" => "12.5", "amount" => "2" }
      }
    end

    before do
      allow(Calculators::DiapersService).to receive(:product_attributes).with(
        ActionController::Parameters.new(params)
      )
      AppConfig.instance.update_diapers_calculator(params)
    end

    it 'receives product attributes' do
      expect(Calculators::DiapersService).to have_received(:product_attributes).with(
        ActionController::Parameters.new(params)
      )
    end
  end
end
