# frozen_string_literal: true

require "rails_helper"

RSpec.describe Account::CalculatorsController, type: :request do
  let(:calculator) { create(:calculator, :diaper_calculator) }
  let(:product) { create(:product, :diaper) }

  let(:valid_attributes) do
    {
      calculator: {
        name: "Test Calculator",
        slug: "test-calculator",
        product_id: product.id
      }
    }
  end

  let(:invalid_attributes) do
    {
      calculator: {
        name: "%^&*()",
        slug: "&",
        product_id: nil
      }
    }
  end

  include_context :authorize_admin

  context "GET #index" do
    it "returns http success and shows all calculators" do
      get account_calculators_path

      expect(response).to be_successful
    end
  end

  context "GET #show" do
    it "returns http success and shows a calculator" do
      get account_calculator_path(calculator)

      expect(response).to be_successful
    end
  end

  context "GET #new" do
    it "returns http success and shows a form for new calculator" do
      get new_account_calculator_path
      expect(response).to be_successful
    end
  end

  context "GET #edit" do
    it "returns http success and shows a form for edit calculator" do
      get edit_account_calculator_path(calculator)

      expect(response).to be_successful
    end
  end

  context "POST #create" do
    it "creates a new calculator" do
      expect { post account_calculators_path, params: valid_attributes }.to change(Calculator, :count).by(1)

      expect(response).to redirect_to(account_calculators_path)
      expect(flash[:notice]).to eq(I18n.t("notifications.calculator_created"))
    end

    it "renders new template with errors if creation fails" do
      post account_calculators_path, params: invalid_attributes
      expect(response).to have_http_status(:unprocessable_entity)

      expect(response).to render_template(:new)
    end
  end

  context "PATCH #update" do
    it "updates the calculator" do
      patch account_calculator_path(calculator), params: { calculator: { name: "Updated Calculator" }}
      calculator.reload

      expect(calculator.name).to eq("Updated Calculator")
      expect(flash[:notice]).to eq(I18n.t("notifications.calculator_updated"))
    end

    it "renders edit template with errors if update fails" do
      patch account_calculator_path(calculator), params: invalid_attributes

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template(:edit)
    end
  end

  context "DELETE #destroy" do
    it "destroys the calculator" do
      post account_calculators_path, params: valid_attributes
      calculator.reload

      expect { delete account_calculator_path(calculator) }.to change(Calculator, :count).by(-1)

      expect(response).to redirect_to(account_calculators_path)
      expect(flash[:notice]).to eq(I18n.t("notifications.calculator_deleted"))
    end
  end
end
