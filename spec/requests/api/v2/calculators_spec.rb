require "rails_helper"

RSpec.describe "Calculators", type: :request do
  let!(:calculator1) { create(:calculator, en_name: "Calculator_1", uk_name: "Калькулятор_1", en_notes: "Note_1", uk_notes: "Опис_1") }
  let!(:calculator2) { create(:calculator, en_name: "Calculator_2", uk_name: "Калькулятор_2", en_notes: "Note_2", uk_notes: "Опис_2") }

  describe "GET /en/api/v2/calculators.json" do
    it "returns calculators" do
      get "/en/api/v2/calculators.json"

      expect(response).to be_successful
      json = response.parsed_body

      expect(json).to eq([
        { "name" => "Calculator_1", "notes" => "Note_1" },
        { "name" => "Calculator_2", "notes" => "Note_2" }
      ])
    end

    it "returns calculators ordered by name descending" do
      get "/en/api/v2/calculators.json", params: { name: "desc" }

      expect(response).to be_successful
      json = response.parsed_body

      expect(json).to eq([
        { "name" => "Calculator_2", "notes" => "Note_2" },
        { "name" => "Calculator_1", "notes" => "Note_1" }
      ])
    end

    it "returns calculators ordered by name ascending" do
      get "/en/api/v2/calculators.json", params: { name: "asc" }

      expect(response).to be_successful
      json = response.parsed_body

      expect(json).to eq([
        { "name" => "Calculator_1", "notes" => "Note_1" },
        { "name" => "Calculator_2", "notes" => "Note_2" }
      ])
    end

    it "returns calculators ordered by name ascending when no name param is given" do
      get "/en/api/v2/calculators.json", params: { name: nil }

      expect(response).to be_successful
      json = response.parsed_body

      expect(json).to eq([
        { "name" => "Calculator_1", "notes" => "Note_1" },
        { "name" => "Calculator_2", "notes" => "Note_2" }
      ])
    end

    it "returns calculators ordered by name ascending when incorrect name param is given" do
      get "/en/api/v2/calculators.json", params: { name: "abc" }

      expect(response).to be_successful
      json = response.parsed_body

      expect(json).to eq([
        { "name" => "Calculator_1", "notes" => "Note_1" },
        { "name" => "Calculator_2", "notes" => "Note_2" }
      ])
    end
  end

  describe "GET /uk/api/v2/calculators.json" do
    it "returns calculators" do
      get "/uk/api/v2/calculators.json"

      expect(response).to be_successful
      json = response.parsed_body

      expect(json).to eq([
        { "name" => "Калькулятор_1", "notes" => "Опис_1" },
        { "name" => "Калькулятор_2", "notes" => "Опис_2" }
      ])
    end

    it "returns calculators ordered by name descending" do
      get "/uk/api/v2/calculators.json", params: { name: "desc" }

      expect(response).to be_successful
      json = response.parsed_body

      expect(json).to eq([
        { "name" => "Калькулятор_2", "notes" => "Опис_2" },
        { "name" => "Калькулятор_1", "notes" => "Опис_1" }
      ])
    end

    it "returns calculators ordered by name ascending" do
      get "/uk/api/v2/calculators.json", params: { name: "asc" }

      expect(response).to be_successful
      json = response.parsed_body

      expect(json).to eq([
        { "name" => "Калькулятор_1", "notes" => "Опис_1" },
        { "name" => "Калькулятор_2", "notes" => "Опис_2" }
      ])
    end

    it "returns calculators ordered by name ascending when no name param is given" do
      get "/uk/api/v2/calculators.json", params: { name: nil }

      expect(response).to be_successful
      json = response.parsed_body

      expect(json).to eq([
        { "name" => "Калькулятор_1", "notes" => "Опис_1" },
        { "name" => "Калькулятор_2", "notes" => "Опис_2" }
      ])
    end

    it "returns calculators ordered by name ascending when incorrect name param is given" do
      get "/uk/api/v2/calculators.json", params: { name: "abc" }

      expect(response).to be_successful
      json = response.parsed_body

      expect(json).to eq([
        { "name" => "Калькулятор_1", "notes" => "Опис_1" },
        { "name" => "Калькулятор_2", "notes" => "Опис_2" }
      ])
    end
  end
end
