# frozen_string_literal: true

require "rails_helper"

RSpec.describe Account::DiapersPeriodsController, type: :request do
  include_context :authorize_admin

  let!(:diapers_period) { create :diapers_period, :with_category }
  let(:valid_params) { attributes_for(:diapers_period, category_id: category.id) }
  let(:invalid_params) { attributes_for(:diapers_period, usage_amount: "", category_id: category.id) }
  let(:new_params) { attributes_for(:diapers_period, usage_amount: 7) }
  let!(:category) { create :category, :budgetary }

  describe "GET #idex" do
    it "is successful" do
      get account_diapers_periods_path(category_id: category.id, format: :turbo_stream)

      expect(response).to be_successful
      expect(response.body).to include(category.name)
    end
  end

  describe "GET #new" do
    it "is successful" do
      get new_account_diapers_period_path(category_id: category.id, format: :turbo_stream)

      expect(response).to be_successful
      expect(response.body).to include(category.name)
    end
  end

  describe "GET #edit" do
    it "is successful" do
      get edit_account_diapers_period_path(diapers_period, category_id: category.id, format: :turbo_stream)

      expect(response).to be_successful
    end
  end

  describe "GET #categories" do
    it "is successful" do
      get categories_account_diapers_periods_path(format: :turbo_stream)

      expect(response).to be_successful
    end
  end

  describe "GET #available_categories" do
    it "is successful" do
      get available_categories_account_diapers_periods_path(format: :turbo_stream)

      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "is successful" do
        expect do
          post account_diapers_periods_path(format: :turbo_stream), params: { diapers_period: valid_params }
        end.to change(DiapersPeriod, :count).by(1)

        expect(response).to render_template(:create)
      end
    end

    context "with invalid parameters" do
      it "is not successful" do
        expect do
          post account_diapers_periods_path(format: :turbo_stream), params: { diapers_period: invalid_params }
        end.not_to change(DiapersPeriod, :count)

        expect(response).to render_template(:new)
        expect(response).to be_unprocessable
      end
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      it "is successful" do
        expect do
          patch account_diapers_period_path(diapers_period, format: :turbo_stream), params: { diapers_period: new_params }

          diapers_period.reload
        end.to change(diapers_period, :usage_amount).to(new_params[:usage_amount])

        expect(response).to render_template(:update)
      end
    end

    context "with invalid parameters" do
      it "is unprocessable" do
        expect do
          patch account_diapers_period_path(diapers_period, category_id: category.id, format: :turbo_stream),
                params: { diapers_period: invalid_params }
        end.not_to change(diapers_period, :usage_amount)

        expect(response).to render_template(:edit)
        expect(response).to be_unprocessable
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested period" do
      expect do
        delete account_diapers_period_path(diapers_period, category_id: category.id, format: :turbo_stream)
      end.to change(DiapersPeriod, :count).by(-1)

      expect(response).to have_rendered(:destroy)
    end

    context "when destroy fails" do
      it "redirects to account_site_setting_path with alert message" do
        allow(DiapersPeriod).to receive(:find).and_return(diapers_period)
        allow(diapers_period).to receive(:destroy).and_return(false)

        delete account_diapers_period_path(diapers_period, format: :turbo_stream),
               params: { id: diapers_period.id, category_id: category.id }

        expect(response).to redirect_to(account_site_setting_path)
        expect(flash[:alert]).to eq(I18n.t("notifications.diapers_period_not_deleted"))
      end
    end
  end

  describe "DELETE #destroy_category" do
    it "destroys all periods in the requested category" do
      expect do
        delete destroy_category_account_diapers_periods_path(category_id: category.id, format: :turbo_stream),
               params: { category_id: category.id }
      end.to change(category.diapers_periods, :count).to(0)

      expect(response).to have_rendered(:destroy_category)
    end

    context "when destroy fails" do
      it "redirects to account_site_setting_path with an alert message" do
        allow_any_instance_of(Category).to receive_message_chain(:diapers_periods, :destroy_all).and_return(false)

        delete destroy_category_account_diapers_periods_path(format: :turbo_stream), params: { category_id: category.id }

        expect(response).to redirect_to(account_site_setting_path)
        expect(flash[:alert]).to eq(I18n.t("notifications.category_diapers_period_not_deleted"))
      end
    end
  end
end
