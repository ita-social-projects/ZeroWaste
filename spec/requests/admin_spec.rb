require 'rails_helper'

RSpec.describe "Admin", type: :request do
  describe "GET /admin" do
    it "returns a 200 custom status code" do
      get "/admin"
      expect(response).to have_http_status(200)
    end
  end
end
