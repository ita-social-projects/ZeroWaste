require "rails_helper"

RSpec.describe Account::ProductsController, type: :request do
  let!(:message) { create(:message, title: "Title") }

  include_context :authorize_admin

  describe "GET :index" do
    it "is successful" do
      get account_messages_path

      expect(response).to be_successful
      expect(response).to render_template(:index)
      expect(response.body).to include(message.title)
    end

    it "returns the expected attributes" do
      Message.ransackable_attributes.each do |attribute|
        get account_messages_path(q: { s: "#{attribute} asc" })
        expect(response).to be_successful

        get account_messages_path(q: { s: "#{attribute} desc" })
        expect(response).to be_successful
      end
    end
  end

  describe "GET :show" do
    it "is successful" do
      get account_message_path(message)

      expect(response).to be_successful
      expect(response).to render_template(:show)
      expect(response.body).to include(message.title)
    end
  end
end
