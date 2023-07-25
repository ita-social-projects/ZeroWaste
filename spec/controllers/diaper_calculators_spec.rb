# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::DiaperCalculatorsController do
  describe "#calculate" do
    context "when no year and no month values" do
      let(:year_and_month_error) do
        {
          error: "Error: please, select years and months"
        }
      end

      it "renders year and month error" do
        get :calculate

        expect(response.status).to eq(422)
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
        post :calculate, params: { childs_months: 0 }

        expect(response.status).to eq(422)
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
        post :calculate, params: { childs_years: 1 }

        expect(response.status).to eq(422)
        expect(response.body).to eq(month_error.to_json)
      end
    end
  end

  describe "sending params to calculate" do
    let(:values) do
      {
        money_spent: 12_718.5,
        money_will_be_spent: 10_614.0,
        used_diapers_amount: 2745.0,
        to_be_used_diapers_amount: 1830.0
      }
    end
    let(:expected_result) do
      {
        result: values,
        date: 12,
        text_products_to_be_used: "diapers to be used in the future",
        text_products_used: "diapers already used"
      }
    end

    context "when get awaited values" do
      include_context :app_config_load

      it "got the expected result" do
        post :calculate, params: { childs_years: 1, childs_months: 0 }

        expect(response).to be_successful
        expect(response.body).to eq(expected_result.to_json)
      end
    end

    context "when get unawaited values" do
      include_context :app_config_load

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
        post :calculate, params: { childs_years: 1, childs_months: 0 }

        expect(response).to be_successful
        expect(response.body).not_to eq(expected_result.to_json)
      end
    end
  end
end
