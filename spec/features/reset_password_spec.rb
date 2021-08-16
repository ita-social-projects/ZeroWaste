# frozen_string_literal: true

require 'rails_helper'
PASSWORD_RESET_PATH = '/users/password/new'

describe 'Password Reset Page', js: true do
  let(:user) { create(:user) }
  let(:calculator) { create(:calculator) }
  context 'when user clicks button Send me reset password instructions' do
    it 'shows message that user will receive reset password instructions' do
      allow_any_instance_of(ApplicationController)
        .to receive(:after_sign_in_path_for)
        .and_return("/calculators/#{calculator.slug}")
      allow(Devise::Mailer).to receive(:reset_password_instructions)
        .and_return(double(deliver: true))
      visit PASSWORD_RESET_PATH
      fill_in 'Email', with: user.email
      click_button 'Send me reset password instructions'
      expect(page).to have_content('If your email address exists')
    end
  end
end

describe 'Log In', js: true do
  context 'when user clicks button Log in' do
    it 'redirect to sign in page' do
      visit PASSWORD_RESET_PATH
      click_link 'Log in'
      expect(page).to have_current_path('/users/sign_in')
    end
  end
end

describe 'Sign Up', js: true do
  context 'when user clicks button Sign up' do
    it 'redirect to sign up page' do
      visit PASSWORD_RESET_PATH
      click_link 'Sign up'
      expect(page).to have_current_path('/users/sign_up')
    end
  end
end
