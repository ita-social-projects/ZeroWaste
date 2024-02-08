# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::DiaperCalculatorsController, type: :request do
  let(:values) do
    {
      money_spent: "29280.0",
      money_will_be_spent: "43920.0",
      used_diapers_amount: "2928.0",
      to_be_used_diapers_amount: "4392.0"
    }
  end
  let(:expected_result) do
    {
      result: values,
      date: 12,
      text_products_to_be_used: "#{values[:to_be_used_diapers_amount]} diapers to be used in the future",
      text_products_used: "#{values[:used_diapers_amount]} diapers already used"
    }
  end

  describe "POST /diaper_calculators" do
    context "when no year and no month values" do
      let(:year_and_month_error) do
        {
          error: "Error: please, select years and months"
        }
      end

      it "renders year and month error" do
        post api_v1_diaper_calculators_path

        expect(response).to be_unprocessable
        expect(response.body).to eq(year_and_month_error.to_json)
      end
    end

    context "when no year value" do
      let(:year_error) do
        {
          error: "Error: please, select years"
        }
      end

      it "renders year error" do
        post api_v1_diaper_calculators_path, params: { childs_months: 0 }

        expect(response).to be_unprocessable
        expect(response.body).to eq(year_error.to_json)
      end
    end

    context "when no month value" do
      let(:month_error) do
        {
          error: "Error: please, select month"
        }
      end

      it "renders month error" do
        post api_v1_diaper_calculators_path, params: { childs_years: 1 }

        expect(response).to be_unprocessable
        expect(response.body).to eq(month_error.to_json)
      end
    end

    context "when get awaited values" do
      let!(:preferable_category) { create(:category, :preferable) }

      it "got the expected result" do
        post api_v1_diaper_calculators_path, params: { childs_years: 1, childs_months: 0 }

        expect(JSON.parse(response.body)).to eq(JSON.parse(expected_result.to_json))
      end
    end

    context "when get unawaited values" do
      let!(:preferable_category) { create(:category, :preferable) }

      let(:invalid_values) do
        {
          money_spent: 42,
          money_will_be_spent: 42,
          used_diapers_amount: 42,
          to_be_used_diapers_amount: 42
        }
      end

      it "got the unexpected result" do
        expected_result[:result] = invalid_values
        post api_v1_diaper_calculators_path, params: { childs_years: 1, childs_months: 0 }

        expect(response).to be_successful
        expect(response.body).not_to eq(expected_result.to_json)
      end
    end
  end
end
