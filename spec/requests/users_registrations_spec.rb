# spec/requests/users_registrations_spec.rb
require 'rails_helper'

RSpec.describe 'Users::RegistrationsController', type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'PUT #update' do
    context 'with valid parameters' do

      it 'redirects to the edit user registration path with a success notice' do
        allow_any_instance_of(User).to receive(:update_without_password).and_return(true)
        put user_registration_path(user)
        expect(response).to redirect_to(edit_user_registration_path)
        follow_redirect!
        expect(response.body).to include(I18n.t("activerecord.attributes.user.successful_update"))
      end

      it 'calls the correct update method' do
        expect_any_instance_of(User).to receive(:update_without_password).and_return(true)
        put user_registration_path(user), params: valid_params
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          user: {
            email: 'invalidemail'
          }
        }
      end

      it 'renders the edit template' do
        allow_any_instance_of(User).to receive(:update_without_password).and_return(false)
        put user_registration_path(user), params: invalid_params
        expect(response).to render_template('devise/registrations/edit')
      end

      it 'does not call any update method' do
        expect_any_instance_of(User).not_to receive(:update_without_password)
        expect_any_instance_of(User).not_to receive(:update_with_password)
        put user_registration_path(user), params: invalid_params
      end
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      get edit_user_registration_path(user)
      expect(response).to render_template(:edit)
    end
  end

  describe '#send_devise_notification' do
    it 'sends the notification via UserMailer' do
      expect(UserMailer).to receive_message_chain(:send, :deliver_later)
        .with(:notification_name, kind_of(User), anything)
      post user_registration_path, params: { user: attributes_for(:user) }
    end
  end

  describe 'protected methods' do
    it 'returns the new user session path for after_inactive_sign_up_path_for' do
      post user_registration_path, params: { user: attributes_for(:user) }
      expect(controller.send(:after_inactive_sign_up_path_for, user)).to eq(new_user_session_path)
    end
  end
end
