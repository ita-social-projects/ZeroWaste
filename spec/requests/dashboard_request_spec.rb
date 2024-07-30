require "rails_helper"

RSpec.describe Account::DashboardController, type: :request do
  context "when the user is signed in" do
    describe "GET :index" do
      include_context :authorize_admin

      it "returns a success response" do
        get account_root_path

        expect(response).to be_successful
        expect(response).to render_template(:index)
        expect(response.body).to include("hello #{current_user.full_name}")
      end
    end
  end

  context "when the user is not signed in" do
    describe "GET :index" do
      it "redirects to the sign-in page" do
        get account_root_path

        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing")
      end
    end
  end
end
