require "rails_helper"

RSpec.describe "Calculators", type: :request do
  let!(:calculator_1) { create(:calculator_name_first) }
  let!(:calculator_2) { create(:calculator_name_second) }
  let(:user) { create(:user) }

  let(:jwt_token) do
    Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
  end

  describe "GET /en/api/v2/calculators.json" do
    it "returns calculators" do
      get "/en/api/v2/calculators.json", headers: { "Authorization" => "Bearer #{jwt_token}" }

      expect(response).to be_successful
      expect(response.parsed_body).to eq([
        { "name" => calculator_1.en_name, "notes" => calculator_1.en_notes },
        { "name" => calculator_2.en_name, "notes" => calculator_2.en_notes }
      ])
    end

    it "returns calculators ordered by name descending" do
      get "/en/api/v2/calculators.json", params: { name: "desc" }, headers: { "Authorization" => "Bearer #{jwt_token}" }

      expect(response).to be_successful
      expect(response.parsed_body).to eq([
        { "name" => calculator_2.en_name, "notes" => calculator_2.en_notes },
        { "name" => calculator_1.en_name, "notes" => calculator_1.en_notes }
      ])
    end

    it "returns calculators ordered by name ascending" do
      get "/en/api/v2/calculators.json", params: { name: "asc" }, headers: { "Authorization" => "Bearer #{jwt_token}" }

      expect(response).to be_successful
      expect(response.parsed_body).to eq([
        { "name" => calculator_1.en_name, "notes" => calculator_1.en_notes },
        { "name" => calculator_2.en_name, "notes" => calculator_2.en_notes }
      ])
    end

    it "returns calculators ordered by name ascending when no name param is given" do
      get "/en/api/v2/calculators.json", params: { name: nil }, headers: { "Authorization" => "Bearer #{jwt_token}" }

      expect(response).to be_successful
      expect(response.parsed_body).to eq([
        { "name" => calculator_1.en_name, "notes" => calculator_1.en_notes },
        { "name" => calculator_2.en_name, "notes" => calculator_2.en_notes }
      ])
    end

    it "returns calculators ordered by name ascending when incorrect name param is given" do
      get "/en/api/v2/calculators.json", params: { name: "abc" }, headers: { "Authorization" => "Bearer #{jwt_token}" }

      expect(response).to be_successful
      expect(response.parsed_body).to eq([
        { "name" => calculator_1.en_name, "notes" => calculator_1.en_notes },
        { "name" => calculator_2.en_name, "notes" => calculator_2.en_notes }
      ])
    end
  end

  describe "GET /uk/api/v2/calculators.json" do
    it "returns calculators" do
      get "/uk/api/v2/calculators.json", headers: { "Authorization" => "Bearer #{jwt_token}" }

      expect(response).to be_successful
      expect(response.parsed_body).to eq([
        { "name" => calculator_1.uk_name, "notes" => calculator_1.uk_notes },
        { "name" => calculator_2.uk_name, "notes" => calculator_2.uk_notes }
      ])
    end

    it "returns calculators ordered by name descending" do
      get "/uk/api/v2/calculators.json", params: { name: "desc" }, headers: { "Authorization" => "Bearer #{jwt_token}" }

      expect(response).to be_successful
      expect(response.parsed_body).to eq([
        { "name" => calculator_2.uk_name, "notes" => calculator_2.uk_notes },
        { "name" => calculator_1.uk_name, "notes" => calculator_1.uk_notes }
      ])
    end

    it "returns calculators ordered by name ascending" do
      get "/uk/api/v2/calculators.json", params: { name: "asc" }, headers: { "Authorization" => "Bearer #{jwt_token}" }

      expect(response).to be_successful
      expect(response.parsed_body).to eq([
        { "name" => calculator_1.uk_name, "notes" => calculator_1.uk_notes },
        { "name" => calculator_2.uk_name, "notes" => calculator_2.uk_notes }
      ])
    end

    it "returns calculators ordered by name ascending when no name param is given" do
      get "/uk/api/v2/calculators.json", params: { name: nil }, headers: { "Authorization" => "Bearer #{jwt_token}" }

      expect(response).to be_successful
      expect(response.parsed_body).to eq([
        { "name" => calculator_1.uk_name, "notes" => calculator_1.uk_notes },
        { "name" => calculator_2.uk_name, "notes" => calculator_2.uk_notes }
      ])
    end

    it "returns calculators ordered by name ascending when incorrect name param is given" do
      get "/uk/api/v2/calculators.json", params: { name: "abc" }, headers: { "Authorization" => "Bearer #{jwt_token}" }

      expect(response).to be_successful
      expect(response.parsed_body).to eq([
        { "name" => calculator_1.uk_name, "notes" => calculator_1.uk_notes },
        { "name" => calculator_2.uk_name, "notes" => calculator_2.uk_notes }
      ])
    end
  end
end
