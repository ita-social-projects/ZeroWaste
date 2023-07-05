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
  let(:json_response) { JSON.parse(response.body) }

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

    it "JSON response contains `result` in the root" do
      expect(json_response["result"]).to be_truthy
    end

    it "JSON response contains `name` and `result` attributes" do
      expect(json_response["result"][0].keys).to contain_exactly(
        "name",
        "result"
      )
    end

    it "JSON response contains field `name` in snake case format" do
      expect(json_response["result"][0]["name"]).to eq("first_result")
    end
  end

  describe "GET /calculator" do
    before do
      get calculator_path
    end

    it "shouldn`t create any instance" do
      expect(response).not_to be_a_new(Calculator)
    end

    it "renders the calculator template" do
      expect(response).to be_successful
      expect(response).to render_template(:calculator)
    end
  end

  describe "POST /calculators/:slug/calculate" do
    context "when the calculator exist" do
      it "renders the calculate template" do
        post calculate_calculator_path(calculator.slug)

        expect(response).to be_successful
        expect(response).to render_template(:calculate)
      end
    end

    context "when the calculator doesn`t exist" do
      it "raises a 404 error" do
        expect { post calculate_calculator_path("nonexistent-slug") }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
