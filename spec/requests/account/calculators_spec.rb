# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Account::CalculatorsController", type: :request do
  include_context :authorize_admin

  let!(:calculator) { create(:calculator) }

  describe "DELETE #destroy" do
    it "destroys the calculator and redirects" do
      expect do
        delete account_calculator_path(calculator)
      end.to change(Calculator, :count).by(-1)

      expect(response).to redirect_to(account_calculators_path)
      expect(flash[:notice]).to eq(I18n.t("notifications.calculator_deleted"))
    end
  end
end
