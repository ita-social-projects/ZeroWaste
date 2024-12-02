# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Account::UsersController", type: :request do
  include_context :authorize_admin

  let!(:user) { create(:user, last_sign_in_at: Time.current) }
  let!(:admin_user) { create(:user, role: :admin) }

  describe "GET #index" do
    let(:csv_content) do
      response.instance_variable_get(:@stream).instance_variable_get(:@buf).join
    end

    it "returns a successful html response" do
      get account_users_path

      expect(response).to be_successful
      expect(response).to render_template(:index)
      expect(response.body).to include(I18n.t("account.users.index.main_header"))
    end

    it "returns a successful csv response" do
      get account_users_path(format: "csv")

      expect(response.header["Content-Type"]).to include "application/octet-stream"
      expect(csv_content).to match(user.email)
      expect(csv_content).to match(user.first_name)
      expect(csv_content).to match(user.last_name)
      expect(csv_content).to include(user.last_sign_in_at.to_s)
    end

    it "returns the expected attributes" do
      User.ransackable_attributes.each do |attribute|
        get account_users_path(q: { s: "#{attribute} asc" })
        expect(response).to be_successful

        get account_users_path(q: { s: "#{attribute} desc" })
        expect(response).to be_successful
      end
    end
  end

  describe "GET #new" do
    it "returns a successful response" do
      get new_account_user_path

      expect(response).to be_successful
      expect(response).to render_template(:new)
      expect(response.body).to include(I18n.t("account.users.new.table.create_new_user"))
    end
  end

  describe "POST #create" do
    let(:valid_params) { attributes_for(:user) }

    context "with valid parameters" do
      it "creates a new user and redirects" do
        expect do
          post account_users_path, params: { user: valid_params }
        end.to change(User, :count).by(1)

        expect(response).to redirect_to(account_user_path(User.last))
        expect(flash[:notice]).to eq(I18n.t("notifications.user_created"))
      end

      it "creates a new user and sends an email" do
        expect do
          post account_users_path, params: { user: valid_params.merge(send_credentials_email: "1") }
        end.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it "creates a new user and doesn`t send an email" do
        expect do
          post account_users_path, params: { user: valid_params.merge(send_credentials_email: "0") }
        end.not_to change { ActionMailer::Base.deliveries.count }
      end
    end

    context "with invalid parameters" do
      it "does not create a new user" do
        expect do
          post account_users_path, params: { user: { email: "" }}
        end.not_to change(User, :count)

        expect(response).to be_unprocessable
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      it "updates the user" do
        expect do
          patch account_user_path(user), params: { user: { email: "new@example.com" }}

          user.reload
        end.to change { user.email }.to("new@example.com")

        expect(response).to redirect_to(account_user_path(user))
        expect(flash[:notice]).to eq(I18n.t("notifications.user_updated"))
      end
    end

    context "with invalid parameters" do
      it "does not update the user" do
        expect do
          patch account_user_path(user), params: { user: { email: "" }}

          user.reload
        end.not_to change { user }

        expect(response).to be_unprocessable
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "PATCH /account/users/:id" do
    context "when trying to block an admin user" do
      it "sets an alert message and redirects to the admin user account page" do
        patch account_user_path(admin_user), params: { user: { blocked: true }}

        expect(response).to redirect_to(account_users_path)

        follow_redirect!

        expect(flash[:alert]).to eq I18n.t("errors.messages.blocked_user_cannot_be_admin")
        expect(response.body).to include(I18n.t("errors.messages.blocked_user_cannot_be_admin"))
      end
    end

    context "when trying to block a non-admin user" do
      it "blocks the user successfully" do
        patch account_user_path(user), params: { user: { blocked: true }}

        expect(response).to redirect_to(account_user_path(user))

        follow_redirect!
        expect(user.reload.blocked).to be_truthy
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the user and redirects to index page" do
      expect do
        delete account_user_path(user)
      end.to change(User, :count).by(-1)

      expect(response).to redirect_to(account_users_path)
      expect(flash[:notice]).to eq(I18n.t("notifications.user_deleted"))
    end
  end
end
