require "rails_helper"

RSpec.describe Account::SiteSettingsController, type: :request do
  describe "GET edit" do
    context "when user is authenticated" do
      include_context :authorize_admin
      let(:site_setting_params) { FactoryBot.attributes_for(:site_setting, :with_valid_site_setting) }

      it "renders the edit template" do
        get edit_account_site_setting_path
        expect(response).to be_successful
        expect(response).to render_template(:edit)
        expect(response.body).to include(site_setting_params[:title])
      end
    end
  end

  describe "PUT update" do
    include_context :authorize_admin
    context "with valid params" do
      let(:site_setting_params) { FactoryBot.attributes_for(:site_setting, :with_valid_site_setting) }
      let(:params) { { site_setting: site_setting_params } }

      it "updates site setting" do
        put account_site_setting_path, params: params

        expect(response).to redirect_to(edit_account_site_setting_path)
        expect(flash[:notice]).to eq(I18n.t("notifications.site_setting_updated"))
        expect(SiteSetting.instance).to be_valid
        expect(SiteSetting.instance.title).to eq("ZeroWaste")
        expect(SiteSetting.instance.favicon.attached?).to be_truthy
      end
    end

    context "with invalid params" do
      let(:site_setting) { SiteSetting.instance }
      let(:site_setting_params) { FactoryBot.attributes_for(:site_setting, :invalid_site_setting) }

      it "renders edit page with error message" do
        put account_site_setting_path, params: { site_setting: site_setting_params }

        expect(response).to render_template(:edit)
        expect(response).not_to have_http_status(:error)
      end
    end
  end
end
