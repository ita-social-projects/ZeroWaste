require "rails_helper"

RSpec.describe Account::DashboardController, type: :request do
  describe "GET :index" do
    context "when the user is signed in" do
      include_context :signed_in_user

      it "returns a success response" do
        expect(response).to be_successful
      end

      it "renders the dashboard template" do
        expect(response).to render_template(:index)
        expect(response.body).to include("hello #{user.full_name}")
      end
    end

    context "when the user is not signed in" do
      it "redirects to the sign-in page" do
        get account_root_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
