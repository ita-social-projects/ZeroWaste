require "rails_helper"

RSpec.describe Account::SiteSettingsController do
  before do
    @user  = create(:user)
    @admin = create(:user, :admin)
  end

  context "GET edit" do
    it "renders the edit template for admin" do
      sign_in @admin

      get :edit

      expect(response).to render_template("edit")
    end

    it "redirects to homepage for user" do
      sign_in @user

      get :edit

      expect(response).to have_http_status(:redirect)
    end
  end

  context "PUT update" do
    before do
      @tempfile = Tempfile.new(["test_image", ".png"], content_type: "image/png")
      @file     = Rack::Test::UploadedFile.new(@tempfile, "image/png")
    end

    after do
      @tempfile.close
      @tempfile.unlink
    end

    it "updates site setting" do
      sign_in @admin

      put :update, params: { site_setting: { title: "Test Title", favicon: @file }}

      expect(response).to redirect_to(edit_account_site_setting_path)
      expect(flash[:notice]).to eq(I18n.t("notifications.site_setting_updated"))
      expect(SiteSetting.instance.valid?).to be_truthy
      expect(SiteSetting.instance.title).to eq("Test Title")
      expect(SiteSetting.instance.favicon.attached?).to be_truthy
    end

    it "renders edit page with error message when validation fails" do
      sign_in @admin

      put :update, params: { site_setting: { title: "", favicon: @file }}

      expect(response).to render_template(:edit)
      expect(SiteSetting.instance.valid?).to be_falsey
      expect(SiteSetting.instance.errors.messages[:title]).to include("can't be blank")
    end
  end
end
