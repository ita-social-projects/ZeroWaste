# frozen_string_literal: true

require "rails_helper"

RSpec.describe CalculatorsController, type: :request do
  let(:calculator) { create(:calculator) }

  describe "GET #index" do
    context "when show_calculators_list feature is enabled" do
      include_context :show_calculators_list

      it "renders the calculators index when show_calculators_list is enabled" do
        get calculators_path

        expect(response).to be_successful
        expect(response).to render_template(:index)
        expect(assigns(:calculators)).not_to be_nil
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
    include_context :authorize_admin

    let!(:formula_1) { create(:formula, calculator: calculator, expression: 'a + b', en_label: 'Sum') }
    let!(:formula_2) { create(:formula, calculator: calculator, expression: 'a * b', en_label: 'Product') }
    let(:inputs) { { a: 4, b: 3 } }

    it 'returns the calculation results' do
      post calculate_calculator_path(calculator), params: { inputs: inputs }, as: :turbo_stream

      expect(response).to be_successful
      expect(response.body).to include('Sum', '7')
      expect(response.body).to include('Product', '12')
    end
  end
end
