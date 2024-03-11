require "rails_helper"

RSpec.describe Account::DiapersPeriods::CategoriesController, type: :request do
  include_context :authorize_admin

  let!(:diapers_period) { create :diapers_period }
  let!(:category) { create :category, :budgetary }

  describe "GET #with_periods" do
    it "is successful" do
      get with_periods_account_diapers_periods_categories_path(format: :turbo_stream)

      expect(response).to be_successful
    end
  end

  describe "GET #available" do
    it "is successful" do
      get available_account_diapers_periods_categories_path(format: :turbo_stream)

      expect(response).to be_successful
    end
  end

  describe "DELETE #destroy" do
    it "destroys all periods in the requested category" do
      expect do
        delete account_diapers_periods_category_path(id: category.id, format: :turbo_stream),
               params: { category_id: category.id }
      end.to change(category.diapers_periods, :count).to(0)

      expect(response).to have_http_status(:see_other)
      expect(response).to have_rendered(:destroy)
      expect(response.body).to include("action=\"remove\" target=\"category_#{category.id}\"")
    end

    context "when destroy fails" do
      it "redirects to account_site_setting_path with an alert message" do
        allow_any_instance_of(Category).to receive_message_chain(:diapers_periods, :destroy_all).and_return(false)

        delete account_diapers_periods_category_path(id: category.id, format: :turbo_stream),
               params: { category_id: category.id  }

        expect(response).to redirect_to(account_site_setting_path)
        expect(flash[:alert]).to eq(I18n.t("notifications.category_diapers_period_not_deleted"))
      end
    end
  end
end
