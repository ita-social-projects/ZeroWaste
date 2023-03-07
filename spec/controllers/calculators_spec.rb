require "rails_helper"

RSpec.describe CalculatorsController, type: :controller do
  let(:calculator) { create(:calculator) }

  describe "GET /show" do
    context "when calculator exist" do
      it "assigns the requested calculator to @calculator" do
        get :show, params: { slug: calculator.slug }

        expect(assigns(:calculator)).to eq(calculator)
        expect(response).to have_http_status(200)
        expect(response).to render_template(:show)
      end
    end

    context "when calculator doesn't exist" do
      it "raises a 404 error" do
        expect do
          get :show, params: { slug: "non-existent-slug" }
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "GET /calculator" do
    it "renders the calculator template" do
      get :calculator

      expect(response).to have_http_status(200)
      expect(response).to render_template(:calculator)
    end
  end

  describe "POST /calculate" do
    context "when the calculator with the specified slug exist" do
      it "renders the calculate template" do
        post :calculate, params: { slug: calculator.slug }

        expect(response).to have_http_status(200)
        expect(response).to render_template(:calculate)
      end
    end

    context "when the calculator with the specified slug does not exist" do
      it "returns a 404 response" do
        expect do
          post :calculate, params: { slug: "nonexistent-slug" }
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "POST /receive_recomendations" do
    let!(:user) { create(:user) }

    before do
      controller.stub(:current_user) { user }
    end

    it "takes user with receive_recomendations:false" do
      expect(user.receive_recomendations).to eq false
    end

    it "doesn`t change user attribute unless user signed in" do
      expect do
        post :receive_recomendations

        user.reload
      end.not_to change { user.receive_recomendations }
    end

    it "changes user's receive_recomendations to true" do
      allow(controller).to receive(:authenticate_user!).and_return(true)

      expect do
        post :receive_recomendations

        user.reload
      end.to change { user.receive_recomendations }.from(false).to(true)
    end

    context "if unauthorized users" do
      it "redirects to the login page" do
        post :receive_recomendations

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
