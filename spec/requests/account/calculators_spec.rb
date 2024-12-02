# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Account::CalculatorsController", type: :request do
  include_context :authorize_admin

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
    context "when in production environment" do
      include_context :in_production_environment

      it "renders the 'under_construction' template" do
        get account_calculators_path

        expect(response).to render_template("shared/under_construction")
      end
    end

    context "when in local environment" do
      include_context :in_local_environment

      it "loads calculators and renders the index template" do
        get account_calculators_path

        expect(response).to render_template(:index)
        expect(assigns(:calculators)).to include(calculator)
      end
    end
  end
  
  describe "GET /calculator" do
    include_context :in_local_environment

    it "renders the calculator template" do
      get account_calculator_path(slug: calculator.slug)

      expect(response).to be_successful
      expect(response).to render_template(:show)
    end
  end
end
