# frozen_string_literal: true

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
end
