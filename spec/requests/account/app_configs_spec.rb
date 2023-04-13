require "rails_helper"

RSpec.describe Account::AppConfigsController, type: :request do
  include_context :authorize_admin
  fixtures :app_configs

  describe "GET :edit" do
    it "is successful" do
      get edit_account_app_config_path

      expect(response).to be_successful
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH #update" do
    let(:app_config_instance) { app_configs(:initial_app_config) }
    let(:diapers_calculator_params) { attributes_for(:diapers_calculator_params) }
    let(:updated_diapers_calculator) { attributes_for(:app_config, :updated) }

    context "passed vaild params" do
      it "updates the AppConfig instances diapers calculator" do
        expect do
          patch account_app_config_path, params: diapers_calculator_params
          app_config_instance.reload
        end.to change(app_config_instance, :diapers_calculator).to(updated_diapers_calculator[:diapers_calculator])
      end
    end
  end
end
