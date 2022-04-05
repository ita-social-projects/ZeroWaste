require 'rails_helper'

RSpec.describe "ContactUs", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/contact_us/index"
      expect(response).to have_http_status(:success)
    end
  end

end
