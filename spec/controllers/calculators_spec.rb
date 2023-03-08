require "rails_helper"

RSpec.describe CalculatorsController, type: :controller do
  describe "GET /calculator" do
    let!(:subject) { get :calculator }

    it "should return success response status" do
      expect(subject).to have_http_status(200)
    end

    it "shouldn`t create any instance" do
      expect(subject).not_to be_a_new(Calculator)
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

    # TODO: rewrite it to good spec
    # it "changes user`s receive_recomendations to true" do
    #   post :receive_recomendations

    #   expect(user.reload.receive_recomendations).to eq(true)
    # end
  end