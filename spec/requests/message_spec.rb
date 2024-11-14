# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Messages", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get new_message_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST :create" do
    let(:valid_message_attributes) { attributes_for(:message) }

    context "with valid attributes" do
      it "creates a message" do
        expect do
          post messages_path, params: { message: valid_message_attributes }
        end.to change(Message, :count).by(1)

        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq(I18n.t("notifications.message_sent"))
      end
    end

    context "with invalid attributes" do
      let(:invalid_message_attributes) { attributes_for(:message, title: "") }

      it "doesn't create a message" do
        expect do
          post messages_path, params: { message: invalid_message_attributes }
        end.not_to change(Message, :count)

        expect(response).to render_template(:new)
      end
    end
  end
end
