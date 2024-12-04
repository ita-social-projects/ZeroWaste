# frozen_string_literal: true

require "rails_helper"

RSpec.describe CalculatorsController, type: :request do
  let(:calculator) { create(:calculator) }

  include_context :enable_calculators_constructor

  describe "GET #index" do
    context "when show_calculators_list feature is enabled" do
      include_context :show_calculators_list

      it "renders the calculators index when show_calculators_list is enabled" do
        get calculators_path

        expect(response).to be_successful
        expect(response).to render_template(:index)
        expect(assigns(:calculators)).not_to be_nil
      end

      context "and constructor flipper is disabled" do
        include_context :disable_calculators_constructor

        it "raises routing error" do
          expect { get calculators_path }.to raise_error(ActionController::RoutingError)
        end
      end
    end

    context "when show_calculators_list feature is disabled" do
      include_context :hide_calculators_list

      it "returns a not found status" do
        get calculators_path
        expect(response).to have_http_status(:not_found)
        expect(response.body).to be_blank
      end
    end
  end

  describe "GET /calculator" do
    context "new version" do
      include_context :new_calculator_design

      it "renders the calculator template and new_calculator_design is on" do
        get calculator_path

        expect(response).to be_successful
        expect(response).to render_template(:new_calculator)
        expect(response.body).to include("results")
      end
    end

    context "old version" do
      include_context :old_calculator_design

      it "renders the calculator template and new_calculator_design is off" do
        get calculator_path

        expect(response).to be_successful
        expect(response).to render_template(:old_calculator)
        expect(response.body).to include("results")
      end
    end
  end

  describe "GET /mhc_calculator" do
    context "mhc calculator is enabled" do
      include_context :mhc_calculator_enabled

      it "renders pad calculator" do
        get mhc_calculator_path

        expect(response).to be_successful
        expect(response).to render_template(:mhc_calculator)
      end
    end

    context "mhc calculator is disabled" do
      include_context :mhc_calculator_disabled

      it "renders pad calculator" do
        expect { get mhc_calculator_path }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  describe "POST #create" do
    include_context :authorize_admin

    let(:valid_attributes) { { en_name: "calculator", uk_name: "калькулятор" } }
    let(:invalid_attributes) { { en_name: "", uk_name: "" } }

    context "with valid attributes" do
      it "creates a calculator" do
        expect do
          post account_calculators_path, params: { calculator: valid_attributes }
        end.to change(Calculator, :count).by(1)

        expect(response).to redirect_to(account_calculators_path)
        expect(flash[:notice]).to eq(I18n.t("notifications.calculator_created"))
      end
    end

    context "with invalid attributes" do
      it "does not create a calculator" do
        expect do
          post account_calculators_path, params: { calculator: invalid_attributes }
        end.not_to change(Calculator, :count)

        expect(response.body).to include(I18n.t("errors.messages.too_short", count: 3))
        expect(response).to render_template(:new)
      end
    end
  end

  describe "POST #calculate" do
    let(:calculator) { create(:calculator) }
    let(:formula) { build(:formula, expression: "a + 5", calculator: calculator) }
    let(:field) { build(:field, var_name: "a", calculator: calculator) }

    it "stores the results in the session under the calculator slug" do
      post calculate_calculator_path(calculator), params: { calculator: calculator, inputs: { a: 5 }, format: :turbo_stream }

      expect(session[:calculation_results]).to have_key(calculator.slug)
      expect(session[:calculation_results][calculator.slug]).to eq(assigns(:results))
    end
  end
end
