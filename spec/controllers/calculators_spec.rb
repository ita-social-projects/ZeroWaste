require "rails_helper"

RSpec.describe CalculatorsController, type: :controller do
  let(:calculator) { create(:calculator) }

  describe ".collection" do
    let!(:calculator1) { create(:calculator) }

    it "returns all Calculator instances" do
      expect(controller.send(:collection)).to match_array([calculator1])
    end
  end

  describe "GET /show" do
    it "assigns the requested calculator to @calculator" do
      get :show, params: { slug: calculator.slug }

      expect(assigns(:calculator)).to eq(calculator)
    end

    it "should return success response status" do
      get :show, params: { slug: calculator.slug }

      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      get :show, params: { slug: calculator.slug }

      expect(response).to render_template(:show)
    end
  end

  describe "GET /calculator" do
    let!(:subject) { get :calculator }

    it "should return success response status" do
      expect(subject).to have_http_status(200)
    end

    it "shouldn`t create any instance" do
      expect(subject).not_to be_a_new(Calculator)
    end
  end

  describe "POST /calculate" do
    it "renders the calculate template" do
      post :calculate, params: { slug: calculator.slug }

      expect(response).to render_template(:calculate)
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
  end
end
