# frozen_string_literal: true

require 'rails_helper'

describe 'Password Reset Page', js: true do
  let(:user) { create(:user) }
  let(:calculator) { create(:calculator) }
  PASSWORD_RESET_PATH = '/users/password/new'

  context "when user clicks button Send me reset password instructions" do
    it "shows message that user will receive reset password instructions" do
      allow_any_instance_of(ApplicationController).to receive(:after_sign_in_path_for).and_return("/calculators/#{calculator.slug}")
      allow(Devise::Mailer).to receive(:reset_password_instructions).and_return(double(deliver: true))
      visit PASSWORD_RESET_PATH
      fill_in 'Email', with: user.email
      click_button 'Send me reset password instructions'
      expect(page).to have_content('If your email address exists in our database, you will receive a password recovery link at your email address in a few minutes.')
    end
  end

  context "when user clicks button Log in" do
    it "redirect to sign in page" do
      visit PASSWORD_RESET_PATH
      click_link 'Log in'
      expect(page).to have_current_path("/users/sign_in")
    end
  end

  context "when user clicks button Sign up" do
    it "redirect to sign up page" do
      visit PASSWORD_RESET_PATH
      click_link 'Sign up'
      expect(page).to have_current_path("/users/sign_up")
    end
  end
end
