# frozen_string_literal: true

require 'rails_helper'

describe 'reset password', js: true do
  let(:user) { create(:user) }
  let(:calculator) { create(:calculator) }
  context "when reset password" do
    it "redirect to sign in page after click the button send me instruction" do
      allow_any_instance_of(ApplicationController).to receive(:after_sign_in_path_for).and_return("/calculators/#{calculator.slug}")
      allow(Devise::Mailer).to receive(:reset_password_instructions).and_return(double(deliver: true))
      visit '/users/password/new' 
      fill_in 'Email', with: user.email
      click_button 'Send me reset password instructions'
      expect(page).to have_selector("a[href='/users/sign_in']")
    end
    it "redirect to sign in page after click the button log in" do
      visit '/users/password/new' 
      click_link 'Log in'
      expect(page).to have_selector("a[href='/users/sign_in']")
    end
    it "redirect to sign in page after click the button sign up" do
      visit '/users/password/new' 
      click_link 'Sign up'
      expect(page).to have_selector("a[href='/users/sign_up']")
    end
  end
end