# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Account::CalculatorsController", type: :request do
  include_context :authorize_admin
  include_context :show_constructor

  let!(:calculator) { create(:calculator) }

  describe "DELETE #destroy" do
    it "destroys the calculator and redirects" do
      expect do
        delete account_calculator_path(calculator)
      end.to change(Calculator, :count).by(-1)

      expect(response).to redirect_to(account_calculators_path)
      expect(flash[:notice]).to eq(I18n.t("notifications.calculator_deleted"))
    end
  end

  describe "GET #index" do
    context "when flipper is turned off" do
      include_context :hide_constructor

      it "raises routing error" do
        expect { get account_calculators_path }.to raise_error(ActionController::RoutingError)
      end
    end

    context "when flipper is turned on" do
      it "loads calculators and renders the index template" do
        get account_calculators_path

        expect(response).to render_template(:index)
        expect(assigns(:calculators)).to include(calculator)
      end
    end
  end
end
