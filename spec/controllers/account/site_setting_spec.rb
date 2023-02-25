require "rails_helper"

RSpec.describe Account::SiteSettingsController do
  describe "GET edit" do
    context "when admin is authenticated" do
      include_context :with_authenticated_admin

      it "renders the edit template" do
        get :edit

        expect(response).to render_template("edit")
      end
    end

    context "when user is authenticated" do
      include_context :with_authenticated_user

      it "redirects to homepage" do
        get :edit

        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe "PUT update" do
    include_context :with_authenticated_admin

    context "with valid params" do
      let(:site_setting_params) { FactoryBot.attributes_for(:site_setting, :with_favicon) }
      let(:params) { { site_setting: site_setting_params } }

      it "updates site setting" do
        put :update, params: params

        expect(response).to redirect_to(edit_account_site_setting_path)
        expect(flash[:notice]).to eq(I18n.t("notifications.site_setting_updated"))
        expect(SiteSetting.instance).to be_valid
        expect(SiteSetting.instance.title).to eq("ZeroWaste")
        expect(SiteSetting.instance.favicon.attached?).to be_truthy
      end
    end

    context "with invalid params" do
      let(:site_setting_params) { FactoryBot.attributes_for(:invalid_site_setting) }
      let(:params) { { site_setting: site_setting_params } }

      it "renders edit page with error message" do
        put :update, params: params

        expect(response).to render_template(:edit)
        expect(SiteSetting.instance).not_to be_valid
        expect(SiteSetting.instance.errors.messages[:title]).to include("can't be blank")
      end
    end
  end
end
