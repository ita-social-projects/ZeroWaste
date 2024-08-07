# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V2::CalculatorsController, type: :request do
  let(:calculator) { create(:calculator) }
  let!(:value_p1) do
    create(:value, value: "10", type: "Value", selector: "P1", label: "one",
                   kind: "parameter",
                   calculator: calculator)
  end
  let!(:value_p2) do
    create(:value, value: "20", type: "Value", selector: "P2", label: "two",
                   kind: "parameter",
                   calculator: calculator)
  end
  let!(:value_p3) do
    create(:value, value: "50", type: "Value", selector: "P3", label: "three",
                   kind: "parameter",
                   calculator: calculator)
  end
  let!(:value_p4) do
    create(:value, value: "60", type: "Value", selector: "P4", label: "four",
                   kind: "parameter",
                   calculator: calculator)
  end
  let(:json_response) { response.parsed_body }

  describe "POST api/v2/calculators/PERMALINK/compute" do
    before do
      create(:range_field, selector: "F1", from: 0, to: 3, value: "300",
                           label: "label", kind: "form", calculator: calculator)
      create(:range_field, selector: "F2", from: 4, to: 6, value: "240",
                           label: "label", kind: "form", calculator: calculator)
      create(:range_field, selector: "F3", from: 7, to: 12, value: "180",
                           label: "label", kind: "form", calculator: calculator)
      create(:range_field, selector: "F4", from: 13, to: 24, value: "120",
                           label: "label", kind: "form", calculator: calculator)
      create(:range_field, selector: "F6", from: 25, to: 30, value: "60",
                           label: "label", kind: "form", calculator: calculator)
      create(:value, value: "10", selector: "F7", label: "one",
                     kind: "parameter",
                     calculator: calculator)

      create(:calculation, value: "ITEMS_PER_MONTH(P1, F1, F2, F3, F4, F5, F6)",
                           selector: "R1", name: "Diapers amount used to date",
                           label: "one", kind: "result", calculator: calculator)
      create(:calculation, value: "10 + P4 ", type: "Calculation", selector: "R2",
                           name: "Second result", label: "one", kind: "result",
                           calculator: calculator)
      create(:calculation, value: "10 + P2 ", type: "Calculation", selector: "R3",
                           name: "Third result", label: "one", kind: "result",
                           calculator: calculator)

      post compute_api_v2_calculator_path(calculator)
    end

    it "http 200" do
      expect(response.status).to eql(200)
    end
    it "result of calculation_r1 is 20" do
      expect(json_response["result"][0]["result"]).to eq(2640)
    end
    it "result of calculation_r2 is 70" do
      expect(json_response["result"][1]["result"]).to eq(70)
      expect(json_response["result"][1].values).to contain_exactly(
        "second_result", 70
      )
    end
    it "result of calculation_r3 is 30" do
      expect(json_response["result"][2]["result"]).to eq(30)
      expect(json_response["result"][2].values).to contain_exactly(
        "third_result", 30
      )
    end
    it do
      expect(json_response["result"][0]["result"]).to be_kind_of(Numeric)
    end
  end
end
