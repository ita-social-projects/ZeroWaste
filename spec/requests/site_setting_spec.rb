require "rails_helper"

RSpec.describe Account::SiteSettingsController, type: :request do
  let(:site_setting) { SiteSetting.current }
  let(:site_setting_params) { attributes_for(:site_setting, :with_valid_site_setting) }
  let(:site_setting_invalid_params) { attributes_for(:site_setting, :invalid_site_setting) }
  let(:site_setting_params_new_title) { attributes_for(:site_setting, :new_title) }

  before { allow(SiteSetting).to receive(:current).and_return(site_setting) }

  include_context :authorize_admin

  describe "GET #edit" do
    context "when user is authenticated" do
      it "renders the edit template" do
        get edit_account_site_setting_path

        expect(response).to be_successful
        expect(response).to render_template(:edit)
        expect(response.body).to include(site_setting_params[:title])
      end
    end
  end

  describe "PATCH #update" do
    before { site_setting.update(site_setting_params) }

    context "with valid params" do
      it "updates site setting" do
        patch account_site_setting_path, params: { site_setting: site_setting_params }

        expect(response).to redirect_to(edit_account_site_setting_path)
        expect(flash[:notice]).to eq(I18n.t("notifications.site_setting_updated"))
        expect(site_setting).to be_valid
        expect(site_setting.favicon.attached?).to be_truthy
      end

      it "change title" do
        expect do
          patch account_site_setting_path, params: { site_setting: site_setting_params_new_title }
        end.to change { site_setting.title }.from("ZeroWaste").to("Test title")
      end
    end

    context "with invalid params" do
      it "renders edit page with error message" do
        patch account_site_setting_path, params: { site_setting: site_setting_invalid_params }

        expect(response).to render_template(:edit)
        expect(response).to be_unprocessable
      end
    end
  end

  describe "PUT #revert" do
    context "with valid params" do
      before { site_setting.update(site_setting_params_new_title) }

      it "reverts site setting" do
        put revert_account_site_setting_path

        expect(response).to redirect_to(edit_account_site_setting_path)
        expect(flash[:notice]).to eq(I18n.t("notifications.site_setting_reverted"))

        expect(site_setting).to be_valid
        expect(site_setting.favicon.attached?).to be_truthy

        expect(site_setting.title).to eq(site_setting_params[:title])
        expect(site_setting.favicon.filename).to eq(site_setting_params[:favicon].original_filename)
      end
    end

    context "with invalid params" do
      before { allow(site_setting).to receive(:update).and_return(false) }

      it "renders edit page with error message" do
        put revert_account_site_setting_path

        expect(response).to render_template(:edit)
        expect(response).to be_unprocessable
      end
    end
  end
end
