# frozen_string_literal: true

require "rails_helper"

RSpec.describe CalculatorsController, type: :request do
  let(:calculator) { create(:calculator) }
  let!(:calculation_r1) do
    create(:calculation, value: "P1 * P2 / P3", type: "Calculation",
                         selector: "R1", name: "First result",
                         label: "one", kind: "result", calculator: calculator)
  end
  let!(:calculation_r2) do
    create(:calculation, value: "10 * P4", type: "Calculation", selector: "R2",
                         name: "Second result",
                         label: "one", kind: "result", calculator: calculator)
  end
  let!(:calculation_p2) do
    create(:calculation, value: "10 * P4", type: "Calculation", selector: "P2",
                         label: "one", kind: "parameter",
                         calculator: calculator)
  end
  let!(:value_r3) do
    create(:value, value: "Value", type: "Value", selector: "R3",
                   name: "Third result",
                   label: "two", kind: "result", calculator: calculator)
  end
  let!(:value_p1) do
    create(:value, value: "Value", type: "Value", selector: "P1",
                   label: "three",
                   kind: "parameter", calculator: calculator)
  end
  let!(:user) { create(:user) }
  let(:json_response) { response.parsed_body }

  describe "POST api/v2/calculators/PERMALINK/compute" do
    before do
      post compute_api_v2_calculator_path(calculator)
    end

    it "returns JSON" do
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json; charset=utf-8")

      expect(json_response).to include("result")
      expect(json_response["result"][0]).to include("name", "result")
    end

    it "JSON response contains 'result' in the root" do
      expect(json_response["result"]).to be_truthy
    end

    it "JSON response contains 'name' and 'result' attributes" do
      expect(json_response["result"][0].keys).to contain_exactly(
        "name",
        "result"
      )
    end

    it "JSON response contains field 'name' in snake case format" do
      expect(json_response["result"][0]["name"]).to eq("first_result")
    end
  end

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

    let(:valid_attributes) { { name: "калькулятор", slug: "test" } }
    let(:invalid_attributes) { { name: "$калькулятор", slug: "test" } }

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

        expect(response.body).to include(I18n.t("activerecord.errors.models.calculator.attributes.name.invalid"))
        expect(response).to render_template(:new)
      end
    end
  end

  describe "POST #receive_recomendations" do
    context "when user sign_in" do
      it "does change recieve_recomendation" do
        sign_in user

        expect do
          post receive_recomendations_path
        end.to change(user, :receive_recomendations)
      end
    end
  end

  describe "POST #calculate" do
    before do
      sign_in user
    end

    it "returns a successful response" do
      post calculate_calculator_path(calculator.slug)

      expect(response).to be_successful
    end
  end
end
