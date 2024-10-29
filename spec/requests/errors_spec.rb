require "rails_helper"

RSpec.describe ErrorsController, type: :request do
  describe "GET #not_found" do
    it "returns a 404 status" do
      get not_found_error_path

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET #unprocessable" do
    it "returns a 422 status" do
      get unprocessable_error_path

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET #internal_server" do
    it "returns a 500 status" do
      get internal_server_error_path

      expect(response).to have_http_status(:internal_server_error)
    end
  end
end
