# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Account::CalculatorsController", type: :request do
  include_context :authorize_admin
  include_context :enable_calculators_constructor

  let!(:calculator) { create(:calculator) }

  let(:user) { create(:user) }
  let(:locale) { "en" }
  let(:new_path) { new_account_calculator_path(locale: locale) }

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
      include_context :disable_calculators_constructor

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

  describe "GET #new" do
    subject { get new_path }

    context "when the user is authorized" do
      it "initializes a new Calculator object with fields and formulas" do
        subject

        expect(response).to have_http_status(:ok)

        calculator = assigns(:calculator)
        expect(calculator).to be_a_new(Calculator)

        expect(calculator.fields.size).to eq(1)
        expect(calculator.formulas.size).to eq(1)

        expect(calculator.fields.first).to be_a_new(Field)
        expect(calculator.formulas.first).to be_a_new(Formula)
      end

      it "renders the new template" do
        subject
        expect(response).to render_template(:new)
      end
    end

    context "when the locale is different" do
      let(:locale) { "uk" }

      it "handles the locale correctly" do
        subject
        expect(I18n.locale).to eq(:uk)
        expect(response).to have_http_status(:ok)
      end
    end

    context "when the user is not logged in" do
      before do
        sign_out(:user)
      end

      it "redirects to the login page" do
        subject
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
