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

  describe "PATCH update" do
    include_context :authorize_admin

    context "with valid params" do
      let(:site_setting_params) { { site_setting: FactoryBot.attributes_for(:site_setting, :with_valid_site_setting) } }
      let(:site_setting_params_new_title) { { site_setting: FactoryBot.attributes_for(:site_setting, :new_title) } }

      it "updates site setting" do
        patch account_site_setting_path, params: site_setting_params

        expect(response).to redirect_to(edit_account_site_setting_path)
        expect(flash[:notice]).to eq(I18n.t("notifications.site_setting_updated"))
        expect(SiteSetting.current).to be_valid
        expect(SiteSetting.current.favicon.attached?).to be_truthy
      end

      it "change title" do
        expect do
          patch account_site_setting_path, params: site_setting_params_new_title
        end.to change { SiteSetting.current.title }.from("ZeroWaste").to("Test title")
      end
    end

    context "with invalid params" do
      let(:site_setting) { SiteSetting.current }
      let(:site_setting_params) { FactoryBot.attributes_for(:site_setting, :invalid_site_setting) }

      it "renders edit page with error message" do
        patch account_site_setting_path, params: { site_setting: site_setting_params }

        expect(response).to render_template(:edit)
        expect(response).to be_unprocessable
      end
    end
  end

  describe "PATCH #revert" do
    include_context :authorize_admin

    context "with valid params" do
      let(:site_setting) { SiteSetting.current }
      let(:site_setting_params) { FactoryBot.attributes_for(:site_setting, :custom_setting) }
      let(:site_setting_default_params) { FactoryBot.attributes_for(:site_setting, :with_valid_site_setting) }

      before { site_setting.update(site_setting_params) }

      it "reverts site setting" do
        patch revert_account_site_setting_path

        expect(response).to redirect_to(edit_account_site_setting_path)
        expect(flash[:notice]).to eq(I18n.t("notifications.site_setting_reverted"))

        expect(SiteSetting.current).to be_valid
        expect(SiteSetting.current.favicon.attached?).to be_truthy

        expect(SiteSetting.current.title).to eq(site_setting_default_params[:title])
        expect(SiteSetting.current.favicon.filename).to eq(site_setting_default_params[:favicon].original_filename)
      end
    end
  end
end
