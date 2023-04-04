require "rails_helper"

RSpec.describe Account::AppConfigsController, type: :request do
  include_context :authorize_admin

  describe "GET :edit" do
    it "is successful" do
      get edit_account_app_config_path

      expect(response).to be_successful
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH #update" do
    let(:diapers_calculator_params) do
      {
        "first_amount" => "10",
        "first_price" => "7.5",
        "second_amount" => "8",
        "second_price" => "9.5",
        "third_amount" => "6",
        "third_price" => "9",
        "fourth_amount" => "6",
        "fourth_price" => "10.5",
        "fifth_amount" => "4",
        "fifth_price" => "10.5",
        "sixth_amount" => "4",
        "sixth_price" => "12.5",
        "seventh_amount" => "2",
        "seventh_price" => "12.5"
      }
    end

    let(:updated_diapers_calculator) do
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

    context "AppConfig instance is created" do
      it "assigns app_config instance" do
        expect do
          patch account_app_config_path, params: diapers_calculator_params
        end.to change { AppConfig.instance.diapers_calculator }.to(updated_diapers_calculator)
      end
    end
  end
end
